#!/bin/bash

set -e -u -x

export GOPATH=$PWD/github.com/bjornm82
export PATH=$PWD/github.com/bjornm82/bin:$PATH

cd concourse

echo $GOPATH
echo $PATH
ls -alh $PWD

echo
echo "Running tests..."
go test -v ./...
