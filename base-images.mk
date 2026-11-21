# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := discourse/base
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_2.0.20261121-0016-web-only := sha256:81a13495c3056e796c2e84319737b5a9404875df6d96e8af3918be814fd488ac
BASE_IMAGE_DIGEST_2.0.20261121-0016-web-only-stable := sha256:d08b6f079764b7bdecbf6a006c6ef3d5e690e3b787eb00ab1266bece449271ed

# Fail before building when a version has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
