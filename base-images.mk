# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := discourse/base
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_2.0.20261119-1637-web-only := sha256:9709707c4546e101d57c540e716794a416aad2f2f8b7bb4f979e23cc4f1047b2
BASE_IMAGE_DIGEST_2.0.20261119-1637-web-only-stable := sha256:bcf27b75592b7c9d0e94993e2916d2b05ffa8444306b561fbf3263dbb67578a5

# Fail before building when a version has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
