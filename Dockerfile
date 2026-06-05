FROM library/golang:1.26.4 AS downloader
RUN mkdir -p /bin-go
RUN GOBIN=/bin-go /usr/local/go/bin/go install github.com/bazelbuild/bazelisk@v1.29.0

FROM ubuntu:25.10 AS main
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=downloader /bin-go/bazelisk /usr/local/bin/bazel

FROM main AS tests
COPY ./tests /tests
WORKDIR /tests
CMD ["./tests.sh"]

