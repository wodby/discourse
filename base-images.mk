# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := discourse/base
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_2.0.20261119-1812-web-only := sha256:637a07b63f750f06aecae599a71b57b5a3922fb3acb713562b62a1bffe9e22b8
BASE_IMAGE_DIGEST_2.0.20261119-1812-web-only-stable := sha256:b6f4304c341bc39a29b3be255019b8586a16949809e8e8f93662d73d62049577

# Fail before building when a version has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
