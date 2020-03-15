DOCKER_REGISTRY = index.docker.io
IMAGE_NAME = mendel-development-tool
IMAGE_VERSION = 1.4.1
IMAGE_ORG = aleravat
IMAGE_TAG = $(DOCKER_REGISTRY)/$(IMAGE_ORG)/$(IMAGE_NAME):$(IMAGE_VERSION)

WORKING_DIR := $(shell pwd)
DOCKERFILE_DIR := $(WORKING_DIR)
DOCKER_RUN_CMD := @docker run \
			-it --rm --network host -v ${HOME}/.config:/root/.config \
			$(DOCKER_REGISTRY)/$(IMAGE_ORG)/$(IMAGE_NAME):$(IMAGE_VERSION)

.DEFAULT_GOAL := run

.PHONY: build push tests

run:: ## Runs the docker image
	$(DOCKER_RUN_CMD)

devices:: ## Runs the docker image
	$(DOCKER_RUN_CMD) mdt devices

shell:: ## Runs the docker image
	$(DOCKER_RUN_CMD) mdt shell

docker-build:: ## Builds the docker image
	@echo Building $(IMAGE_TAG)
	@docker build --pull \
		-t $(IMAGE_TAG) $(DOCKERFILE_DIR)

docker-push:: ## Pushes the docker image to the registry
	@echo Pushing $(IMAGE_TAG)
	@docker push $(IMAGE_TAG)

docker-release:: docker-build docker-push ## Builds and pushes the docker image to the registry

# A help target including self-documenting targets (see the awk statement)
define HELP_TEXT
Usage: make [TARGET]... [MAKEVAR1=SOMETHING]...

Available targets:
endef
export HELP_TEXT
help: ## This help target
	@echo
	@echo "$$HELP_TEXT"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / \
		{printf "\033[36m%-30s\033[0m  %s\n", $$1, $$2}' $(MAKEFILE_LIST)
