package main

// This import exists solely to pin the bazelisk version in go.mod so that
// `go mod tidy` does not remove it. The Dockerfile reads go.mod to determine
// which bazelisk release to download.
import _ "github.com/bazelbuild/bazelisk/core"

func main() {}
