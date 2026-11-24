# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := discourse/base
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_2.0.20261124-0015-web-only := sha256:e8146e17f904258d216c2f2594f9293fe4bf3d18588d370563d7d8d9bd08bc9c
BASE_IMAGE_DIGEST_2.0.20261124-0015-web-only-stable := sha256:0849f3d9eb3eec82d948089190a691f1f4157161e9d9c29ab6164c68fa3fb58d

# Fail before building when a version has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
