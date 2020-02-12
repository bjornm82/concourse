#!/bin/bash

set -e -u -x

export GOPATH=$PWD/gopath
export PATH=$PWD/gopath/bin:$PATH

cd concourse

echo ls -alh
echo "Running tests..."
go test -v ./...
