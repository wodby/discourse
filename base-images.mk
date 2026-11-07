# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := discourse/base
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_2.0.20261107-0014-web-only := sha256:ecd6daa54ba50793036f2a8ccb0ed2193e2b1ee605547ef3cf4f4302d53e0c9d
BASE_IMAGE_DIGEST_2.0.20261107-0014-web-only-stable := sha256:fbc6152fe93e4ecf87e4f48a487c7177723efba5c027f85a3b79539c68981c83

# Fail before building when a version has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
