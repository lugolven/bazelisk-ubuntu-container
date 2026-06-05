#!/bin/bash

set -euo pipefail

echo -e "Testing the image..."
docker run -t $(docker build -q . --target tests)
echo -e "Image tested.