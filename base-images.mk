# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := discourse/base
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_2.0.20261122-0017-web-only := sha256:4d02e5959cef53e4e00ac95bd657896e4b0e109eca47ac4122efbbad6cc286c7
BASE_IMAGE_DIGEST_2.0.20261122-0017-web-only-stable := sha256:644082cc97ab826d678479fd3a38ba08592726c8688637d15d24b762df5f5afe

# Fail before building when a version has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
