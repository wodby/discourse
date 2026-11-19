# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := discourse/base
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_2.0.20261119-0016-web-only := sha256:f02122eb3da30a168cd2b5d3b9a6d1a72f7fdfef326f6c6e88721b669ccb1001
BASE_IMAGE_DIGEST_2.0.20261119-0016-web-only-stable := sha256:746186cd4092529d9feab2726583939dcc2815b89d87bb6d7b32db85e6ed848d

# Fail before building when a version has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
