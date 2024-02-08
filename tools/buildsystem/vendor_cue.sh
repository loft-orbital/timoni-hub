#!/usr/bin/env bash

set -e

vendor_dir="cue.mod/pkg"

# Get the project id from first argument
project_id=$1

# Get dependencies of that project
deps=$(moon project "$project_id" --json | gojq -r '.dependencies[].id')

# Vendor each deps
for dep in $deps; do
    dep_wd=$(moon project "$dep" --json | gojq -r '.root')
    cue_mod_file="$dep_wd/cue.mod/module.cue"
    if [ ! -f "$cue_mod_file" ]; then
        echo "Skipping $dep as it is not a cue module"
        continue
    fi
    dist_file="$dep_wd/dist.tar.gz"
    module_name=$(cue eval -e module "$cue_mod_file" --out text)
    echo "Vendoring $dep as $module_name"
    mkdir -p "$vendor_dir/$module_name"
    tar -xzf "$dist_file" -C $vendor_dir/"$module_name"
done
