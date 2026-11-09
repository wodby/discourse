# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := discourse/base
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_2.0.20261109-0018-web-only := sha256:81b70d37a662ac52573a04651557cda0d798b328cfe8c6cf4e5a848e3b3c777a
BASE_IMAGE_DIGEST_2.0.20261109-0018-web-only-stable := sha256:8970b73581dffa2e719d89ed1da78517acdb54a8748e59764396689d282548c0

# Fail before building when a version has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
