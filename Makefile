.DEFAULT_GOAL := all

SHELL := /bin/bash

makefile := $(abspath $(lastword $(MAKEFILE_LIST)))

tag := fix-creation-date

.PHONY: all
all: ## output targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(makefile) | awk 'BEGIN { FS = ":.*?## " }; { printf "\033[36m%-30s\033[0m %s\n", $$1, $$2 }'

.PHONY: build
build: ## build Docker image
	DOCKER_BUILDKIT=1 docker build --tag $(tag) .

.PHONY: run
run: options := --volume $$(pwd)/share:/root/share --rm
run: ## run Docker container
	docker run $(options) $(tag)

.PHONY: i-run
i-run: options := --volume $$(pwd)/share:/root/share --interactive --rm --tty
i-run: ## run Docker container and attach TTY
	docker run $(options) $(tag) /bin/bash
