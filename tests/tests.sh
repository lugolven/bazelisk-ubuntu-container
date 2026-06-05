#!/bin/bash

set -euo pipefail

echo -e Validating the image
bazel version | egrep 9.1.1 && echo -e "✅  Validated bazel version" || { echo -e "❌ Invalid bazel version"; exit 1; }
echo Done
exit 0