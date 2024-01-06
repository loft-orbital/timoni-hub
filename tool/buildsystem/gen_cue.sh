#!/usr/bin/env bash

set -e

# Generate k8s definitions
echo "Generating k8s definitions for $K8S_VERSION..."
timoni mod vendor k8s -v "$K8S_VERSION"
