# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := discourse/base
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_2.0.20261118-0016-web-only := sha256:987575dedc0acb2f67461449133da5c76c89fc26b75cb9bf2f2b1b0c5e429cbe
BASE_IMAGE_DIGEST_2.0.20261118-0016-web-only-stable := sha256:cdb30892afbc9c620d8524e66a00b497f025fdce8848041292aac9311ffc050d

# Fail before building when a version has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
