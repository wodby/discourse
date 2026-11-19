# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := discourse/base
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_2.0.20261119-1019-web-only := sha256:f558487a9f85b541e83637a25b40ce9131a4114f1895000504226b3e8054c4ac
BASE_IMAGE_DIGEST_2.0.20261119-1019-web-only-stable := sha256:3c0251d00eff9441a2f0e5b1c818f698d6b6e29a96c2a5f98dfb84d07cc0f9e9

# Fail before building when a version has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
