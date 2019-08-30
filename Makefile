.DEFAULT_GOAL := all

SHELL := /bin/bash

makefile     := $(abspath $(lastword $(MAKEFILE_LIST)))
makefile_dir := $(dir $(makefile))

tag := fix-creation-date

.PHONY: all
all: ## output targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(makefile) | awk 'BEGIN { FS = ":.*?## " }; { printf "\033[36m%-30s\033[0m %s\n", $$1, $$2 }'

.PHONY: build
build: ## build Docker image
	DOCKER_BUILDKIT=1 docker build --tag $(tag) .

.PHONY: pull-run
pull-run: image := sasaplus1/$(tag)
pull-run: options := --rm --volume $$(pwd)/share:/root/share
pull-run: ## pull Docker image and run
	docker pull $(image)
	docker run $(options) $(image)

.PHONY: run
run: options := --rm --volume $$(pwd)/share:/root/share --rm
run: ## run Docker container
	docker run $(options) $(tag)
