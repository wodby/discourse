# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := discourse/base
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_2.0.20261117-0016-web-only := sha256:cf2e4413dce4922db4f5405b48ffbad8fd099911a56bff5952081298cb85f67c
BASE_IMAGE_DIGEST_2.0.20261117-0016-web-only-stable := sha256:4b800a26c38377a489c456c18e2e950ac93ab59af48dbd65c727256bdffbfa5a

# Fail before building when a version has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
