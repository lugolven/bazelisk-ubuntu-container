#!/bin/bash

set -euo pipefail

echo "::group::Building the tag image..." >&2
TAG_IMAGE_ID=$(docker build . --target tag --iidfile /tmp/image-id && cat /tmp/image-id)
echo "::endgroup::" >&2

echo "::group::Generating the tag for the image..." >&2
TAG=$(docker run --rm $TAG_IMAGE_ID)
echo "::endgroup::" >&2

echo "Publishing the image with tag $TAG" >&2
