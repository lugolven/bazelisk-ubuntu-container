FROM --platform=$BUILDPLATFORM ubuntu:25.10 AS downloader
ARG TARGETARCH
# Copy the tracking file into the container
COPY go.mod /tmp/go.mod

# Ensure curl and awk are available
RUN apt-get update && apt-get install -y curl ca-certificates

# Parse the version from go.mod and use it to download the official binary
RUN mkdir -p /bin-go 
RUN BAZELISK_VERSION=$(awk '/github.com\/bazelbuild\/bazelisk/ {print $3}' /tmp/go.mod) \
    && curl -fLo /usr/local/bin/bazel "https://github.com/bazelbuild/bazelisk/releases/download/${BAZELISK_VERSION}/bazelisk-linux-${TARGETARCH}"
RUN chmod +x /usr/local/bin/bazel

FROM ubuntu:25.10 AS main
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=downloader /usr/local/bin/bazel /usr/local/bin/bazel

FROM main AS tag
COPY generate-tag.sh ./generate-tag.sh
CMD ["./generate-tag.sh"]

