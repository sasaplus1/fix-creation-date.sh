.DEFAULT_GOAL := all

SHELL := /bin/bash

makefile := $(abspath $(lastword $(MAKEFILE_LIST)))
makefile_dir := $(dir $(makefile))

.PHONY: all
all: ## output targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(makefile) | awk 'BEGIN { FS = ":.*?## " }; { printf "\033[36m%-30s\033[0m %s\n", $$1, $$2 }'

.PHONY: run
run: options := --rm
run: ## run Docker container
	docker-compose run $(options) $@

.PHONY: sh
sh: options := --rm
sh: ## run Docker container and connect to inside
	docker-compose run $(options) $@
