#!/bin/bash

set -e -u -x

export GOPATH=$PWD/gopath
export PATH=$PWD/gopath/bin:$PATH

cd gopath/src/github.com/bjornm82/concourse

echo
echo "Running tests..."
go test -v ./...
