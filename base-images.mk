# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := discourse/base
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_2.0.20261108-0018-web-only := sha256:0f60302c49c7a2e0acbf60d276ee8c04f093b7f8fbdb6591053866c9044289c8
BASE_IMAGE_DIGEST_2.0.20261108-0018-web-only-stable := sha256:0e9b00097b74c031cfbfc752e1cfd2775d0bb4fef4e701f4479740a8d85983e7

# Fail before building when a version has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
