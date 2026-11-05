# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := discourse/base
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_2.0.20261028-0019-web-only := sha256:d7dbab0a9d77909cc20bb35da730ef15e3a38a3f5d287e47e1acc231c4c07dce
BASE_IMAGE_DIGEST_2.0.20261028-0019-web-only-stable := sha256:fe64f428eafb1dfac67be2a40081a4c57f67ded287dc0e25a5867eed89a3f96e

# Fail before building when a version has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
