
# Init variables
VERSION ?= $(shell git describe --tags --always)
COMMIT ?= $(shell git rev-parse HEAD)
BRANCH ?= $(shell git rev-parse --abbrev-ref HEAD)

LDFLAGS = "-w -X main.Version=$(VERSION) -X main.COMMIT=${COMMIT} -X main.BRANCH=${BRANCH}"

GITHUB_ORG_NAME = bjornm82
GITHUB_PROJECT = concourse
PROJECT_DIR ?= ${GOPATH}/src/github.com/${GITHUB_ORG_NAME}/${GITHUB_PROJECT}

APP ?= concourse
OS ?= linux
ARCH ?= amd64

build:
	@CGO_ENABLED=0 GOOS=$(OS) GOARCH=$(ARCH) go build -installsuffix cgo -o bin/$(APP) -a -tags netgo -ldflags $(LDFLAGS) main.go

docker-compose:
	$(MAKE) build-all
	docker-compose up --build

# .PHONY: build
# go build
