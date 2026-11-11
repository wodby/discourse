-include env_make

# A Discourse release, such as 2026.10.0. Its first two parts name the release
# line the image is published for: 2026.10 for the monthly release, 2026.7 for
# the extended support release (ESR).
DISCOURSE_VER ?= 2026.10.1
DISCOURSE_VER_MINOR := $(basename $(DISCOURSE_VER))

# Discourse publishes web-only base images for its main branch and for the ESR
# line, with the Ruby and JavaScript dependencies of that line installed. The
# monthly release uses the dated main image; the ESR line uses the -stable one.
DISCOURSE_BASE_TAG_2026.10 := 2.0.20261109-0018-web-only
DISCOURSE_BASE_TAG_2026.7 := 2.0.20261109-0018-web-only-stable

TAG ?= $(DISCOURSE_VER_MINOR)

REPO = wodby/discourse
NAME = discourse-$(DISCOURSE_VER_MINOR)

IMAGETOOLS_TAG ?= $(TAG)

ifneq ($(ARCH),)
	override TAG := $(TAG)-$(ARCH)
endif

.PHONY: build test push shell run clean buildx-imagetools-create

# Resolve the same pinned base image for every local and CI build target.
include base-images.mk
BASE_IMAGE_TAG = $(or $(DISCOURSE_BASE_TAG_$(DISCOURSE_VER_MINOR)),$(error No base image for Discourse $(DISCOURSE_VER_MINOR); add DISCOURSE_BASE_TAG_$(DISCOURSE_VER_MINOR)))

default: build

build:
	docker build --build-arg BASE_IMAGE="$(BASE_IMAGE)" --build-arg DISCOURSE_VER="$(DISCOURSE_VER)" -t $(REPO):$(TAG) ./

test:
	cd ./tests && IMAGE=$(REPO):$(TAG) NAME=$(NAME) DISCOURSE_VER=$(DISCOURSE_VER) ./run.sh

push:
	docker push $(REPO):$(TAG)

buildx-imagetools-create:
	docker buildx imagetools create -t $(REPO):$(IMAGETOOLS_TAG) \
				$(REPO):$(TAG)-amd64 \
				$(REPO):$(TAG)-arm64

shell:
	docker run --rm --name $(NAME) -i -t $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) /bin/bash

run:
	docker run --rm --name $(NAME) $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) $(CMD)

clean:
	-docker rm -f $(NAME)
