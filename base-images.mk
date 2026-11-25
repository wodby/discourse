# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := discourse/base
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_2.0.20261125-0016-web-only := sha256:83564af4c973eedd4ccfa878f32e274ba93c433f324e74e2fdd32182b7c1b4e4
BASE_IMAGE_DIGEST_2.0.20261125-0016-web-only-stable := sha256:d19a8ff29cad6fcae327824d91d4a269782ac9f8a8f6c90f49e53f6c9f06f663

# Fail before building when a version has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
