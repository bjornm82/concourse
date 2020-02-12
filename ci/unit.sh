#!/bin/bash

set -e -u -x

export GOPATH=$PWD/gopath
export PATH=$PWD/gopath/bin:$PATH

cd concourse

echo $GOPATH
echo $PATH
ls -alh $PWD

echo
echo "Running tests..."
go test -v ./...
