.DEFAULT_GOAL := all

SHELL := /bin/bash

makefile := $(abspath $(lastword $(MAKEFILE_LIST)))
makefile_dir := $(dir $(makefile))

slug := sasaplus1/fix-creation-date.sh

.PHONY: all
all: ## output targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(makefile) | awk 'BEGIN { FS = ":.*?## " }; { printf "\033[36m%-30s\033[0m %s\n", $$1, $$2 }'

.PHONY: build
build: export DOCKER_BUILDKIT=1
build: ## build Docker image
	docker build -t $(slug) .

.PHONY: help
help: ## output how to execute
	@echo '$$ make build'
	@echo '$$ ls -1 *.mp4 | xargs -n 1 docker run --rm -v "$$PWD:/mnt" $(slug)'

.PHONY: sh
sh: ## run Docker container and connect to inside
	docker run -it --rm -v "$$PWD:/mnt" --entrypoint bash $(slug)

.PHONY: test
test: ## lint shell script with shellcheck
	docker run --rm -v "$$PWD:/mnt" koalaman/shellcheck:stable fix-creation-date.sh
