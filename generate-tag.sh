#!/bin/bash

set -euo pipefail

echo "Getting the Bazelisk version" >&2
BAZELISK_VERSION=$(bazel version | grep "Bazelisk version:" | egrep -o '[0-9]+\.[0-9]+\.[0-9]+')

echo "Getting the Ubuntu version" >&2 
UBUNTU_VERSION=$(cat /etc/os-release | grep VERSION_ID | cut -d= -f2 | tr -d '"')

echo -n "$UBUNTU_VERSION-$BAZELISK_VERSION"