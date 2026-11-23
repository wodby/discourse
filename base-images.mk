# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := discourse/base
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_2.0.20261123-0017-web-only := sha256:3022dba390baf7fe4d023145705b2f9a69d0c6ecbeadcaad3425dc8fb79d20dc
BASE_IMAGE_DIGEST_2.0.20261123-0017-web-only-stable := sha256:c88d959d7997a63b2b55af69836bea3b08303fdebe5b7d082568aa27f2c38472

# Fail before building when a version has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
