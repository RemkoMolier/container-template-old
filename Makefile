# Concise introduction to GNU Make:
# https://swcarpentry.github.io/make-novice/reference.html
include .env

# Taken from https://www.client9.com/self-documenting-makefiles/
help : ## Print this help
	@awk -F ':|##' '/^[^\t].+?:.*?##/ {\
		printf "\033[36m%-30s\033[0m %s\n", $$1, $$NF \
	}' $(MAKEFILE_LIST)
.PHONY : help
.DEFAULT_GOAL := help

APPLICATION_VERSION=$(shell RELEASE="${RELEASE}"; echo "$${RELEASE%-r*}";)
ALPINE_SUFFIX=$(shell RELEASE="${RELEASE}"; echo "r$${RELEASE#*-r}";)
BUILD_DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
VCS_REF=$(shell git log --pretty=format:"%H" -n 1)

variables : ## Print value of variables
	@echo NAME: ${NAME}
	@echo RELEASE: ${RELEASE}
	@echo APPLICATION_VERSION: ${APPLICATION_VERSION}
	@echo ALPINE_SUFFIX: ${ALPINE_SUFFIX}
	@echo BUILD_DATE: ${BUILD_DATE}
	@echo VCS_REF: ${VCS_REF}
.PHONY : name

# --------------------- #
# Interface with Docker #
# --------------------- #

# To debug errors during build add `--progress plain \` to get additional
# output.
build : ## Build image with name `${NAME}`, for example, `make build`
	DOCKER_BUILDKIT=1 \
	docker build \
		--tag ${NAME} \
		--pull \
		--build-arg APPLICATION_VERSION=${APPLICATION_VERSION} \
		--build-arg ALPINE_SUFFIX=${ALPINE_SUFFIX} \
		--build-arg BUILD_DATE=${BUILD_DATE} \
		--build-arg VCS_REF=${VCS_REF} \
		--load \
		.
.PHONY : build
