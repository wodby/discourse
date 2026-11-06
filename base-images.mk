# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := discourse/base
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_2.0.20261106-0017-web-only := sha256:6b73c2c701fca46cecf994eed41369adef70480177054a30f8e00495dff09922
BASE_IMAGE_DIGEST_2.0.20261106-0017-web-only-stable := sha256:2efff982382b6afd7a4ce8a2036c0b43bb0aa81b39584c7de1626e71f2438d2d

# Fail before building when a version has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
