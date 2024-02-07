#!/usr/bin/env bash

set -e

examples=$(find examples -type f -name '*.cue' | sort -u)

# Run timoni vet on all examples
for example in $examples; do
  echo "Validating $example"
  timoni mod vet -f "$example"
  echo ""
done
