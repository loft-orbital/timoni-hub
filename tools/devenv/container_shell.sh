#!/usr/bin/env bash

container_cli=$1
container_image=$2
container_name=$3
current_dir=$4

# Check if the container is present and stopped
if [ "$($container_cli ps -a -q -f name="$container_name")" ]; then
    $container_cli start --attach --interactive "$container_name"
else
  $container_cli run \
    --name "$container_name" \
    --volume "$current_dir:/workspace" \
    --workdir /workspace \
    --interactive \
    --tty \
    "$container_image"
fi
