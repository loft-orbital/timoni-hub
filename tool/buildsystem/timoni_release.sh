#!/usr/bin/env bash

set -e

# Check if at least one argument is provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 module-name"
    exit 1
fi

repository="oci://ghcr.io/loft-orbital/timoni/$1"
gitroot=$(git rev-parse --show-toplevel)

# Get module dependencies
deps=$(moon project "$1" --json | jq -re '[.dependencies[].id] | join(" ")')
echo "Module dependencies: $deps"

# Default new version to 1.0.0
new_version="1.0.0"
if output=$(timoni mod list "$repository" --with-digest=false 2>&1); then
	# Module exists, get the last version
	old_version=$(echo "$output" | awk 'NR == 3 { print $1 }')
	echo "Last version: $old_version"

	# Build conventional_commits_next_version args
	ccnv_args=()
	ccnv_args+=("--from-version" "$old_version")
	ccnv_args+=("--calculation-mode" "Batch")

	# Get the latest git tag or initial commit if none
	ref=$(git tag --sort=-committerdate | head -n1)
	if [ -z "$ref" ]; then
		ccnv_args+=("--from-commit-hash" "$(git rev-list --max-parents=0 origin/main)")
	else
		ccnv_args+=("--from-reference" "$ref")
	fi
	# Filter commits to only those affecting the module or its dependencies
	for dep in $1 $deps; do
	    droot=$(moon project "$dep" --json | jq -re '.root')
	    drel=${droot#"$gitroot"/}
	    ccnv_args+=("--monorepo" "$drel")
	done

	# Get the next version
	echo "Calculating next version with args:" "${ccnv_args[@]}"
	new_version=$(conventional_commits_next_version "${ccnv_args[@]}")

	# Check if the new version is the same as the old one
	if [ "$new_version" == "$old_version" ]; then
	    echo "No changes implying a release since last version $old_version"
	    exit 0
	fi
fi

# Release the module
echo "Need to release $1 $new_version"
timoni mod push . "$repository" --version="$new_version" --sign=cosign

# Append release note to release notes file
echo "- **$1**:$new_version" >> "$gitroot/module_release.md"
