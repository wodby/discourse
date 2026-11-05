# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := discourse/base
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_2.0.20261105-0016-web-only := sha256:3dc08799571d03f7bcc6823e09984db57c3442e388eeff7927f9f20910156e05
BASE_IMAGE_DIGEST_2.0.20261105-0016-web-only-stable := sha256:12c60ecb9b05c50959fe48c3a64129a46b6950edf2f3c13771e42867db0602f3

# Fail before building when a version has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
