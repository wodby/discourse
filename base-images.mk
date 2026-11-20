# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := discourse/base
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_2.0.20261120-0015-web-only := sha256:d4f92281e54d3a72edc8a71c6d11e65913c4adb9bf5b2808a7d8e01c8eb6a03a
BASE_IMAGE_DIGEST_2.0.20261120-0015-web-only-stable := sha256:d933cbbca743657fed3cfa4196f4d05d4723fab63e674dc0c10b4ce0dcdc848c

# Fail before building when a version has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
