
# Init variables
VERSION ?= $(shell git describe --tags --always)
COMMIT ?= $(shell git rev-parse HEAD)
BRANCH ?= $(shell git rev-parse --abbrev-ref HEAD)

LDFLAGS = "-w -X main.Version=$(VERSION) -X main.COMMIT=${COMMIT} -X main.BRANCH=${BRANCH}"

GITHUB_ORG_NAME ?= bjornm82
GITHUB_PROJECT ?= concourse
PROJECT_DIR ?= ${GOPATH}/src/github.com/${GITHUB_ORG_NAME}/${GITHUB_PROJECT}

DOCKERHUB_ORG_NAME ?= bjornmooijekind

APP ?= concourse
OS ?= linux
ARCH ?= amd64

.PHONY: build
build:
	@CGO_ENABLED=0 GOOS=$(OS) GOARCH=$(ARCH) go build -installsuffix cgo -o bin/$(APP) -a -tags netgo -ldflags $(LDFLAGS) main.go

.PHONY: run
run:
	$(MAKE) build
	docker-compose up --build -d

.PHONY: build-image
build-image:
	docker build -t $(DOCKERHUB_ORG_NAME)/$(GITHUB_PROJECT):$(BRANCH)-$(VERSION) .

.PHONY: push-image
push-image:
	docker push $(DOCKERHUB_ORG_NAME)/$(GITHUB_PROJECT):$(BRANCH)-$(VERSION)
