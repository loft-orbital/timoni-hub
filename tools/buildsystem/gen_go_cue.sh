#!/usr/bin/env bash

set -e

# Get a list of module to generate
modules=$(go list -f '{{ join .Imports "\n" }}')

# Generate the go files
for module in $modules; do
  cue get go "$module"
done
