# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := discourse/base
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_2.0.20261127-0016-web-only := sha256:32caf5a0045d3fb539b730ee43e20f1b7ca753ca451bc016d808e4cc6995cdd6
BASE_IMAGE_DIGEST_2.0.20261127-0016-web-only-stable := sha256:fdf31fccd493c4dbebae98928bc4c89d40a500cfec40f52a8d6b25d5cd628916

# Fail before building when a version has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
