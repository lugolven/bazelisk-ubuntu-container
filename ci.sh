#!/bin/bash

set -euo pipefail

PR_ID=""
REGISTRY=""
while [[ $# -gt 0 ]]; do
  case $1 in
    --pull-request) PR_ID="$2"; shift 2 ;;
    --registry) REGISTRY="$2"; shift 2 ;;
    *) echo "Unknown argument: $1" >&2; exit 1 ;;
  esac
done

if [[ -z "$REGISTRY" ]]; then
  echo "--registry is required" >&2
  exit 1
fi

echo "::group::Building the tag image..."
TAG_IMAGE_ID=$(docker build . --target tag --iidfile /tmp/image-id && cat /tmp/image-id)
echo "::endgroup::"

echo "::group::Generating the tag for the image..."
TAG=$(docker run --rm $TAG_IMAGE_ID)${PR_ID:+-pr$PR_ID}
echo "Tag: $TAG"
echo "::endgroup::"

echo "::group::Building the main image..."
docker build . --target main -t "$REGISTRY:$TAG"
echo "::endgroup::"

echo "::group::Publishing the image..."
docker push "$REGISTRY:$TAG"
echo "::endgroup::"
