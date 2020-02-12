#!/bin/bash

set -e -u -x

export GOPATH=$PWD/gopath
export PATH=$PWD/gopath/bin:$PATH

cd concourse

echo
echo "Running tests..."
go test -v ./...
