#!/bin/bash

set -euo pipefail

echo "::group::Building the tag image..."
TAG_IMAGE_ID=$(docker build . --target tag --iidfile /tmp/image-id && cat /tmp/image-id)
echo "::endgroup::"

echo "::group::Generating the tag for the image..."
TAG=$(docker run --rm $TAG_IMAGE_ID)
echo "::endgroup::"

echo "Publishing the image with tag $TAG"
