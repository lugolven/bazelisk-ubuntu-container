#!/bin/bash

set -euo pipefail

echo "Building the image..." >&2
TAG_IMAGE_ID=$(docker build . --target tag --iidfile /tmp/image-id && cat /tmp/image-id)

echo "Generating the tag for the image..." >&2
TAG=$(docker run --rm $TAG_IMAGE_ID)

echo "Publishing the image with tag $TAG" >&2
