# Base image inputs shared by local builds and CI. Updated by wodby/images.
# Each digest identifies the complete multi-platform image index.
BASE_IMAGE_REPOSITORY := discourse/base
BASE_IMAGE_VERSION_SUFFIX :=

BASE_IMAGE_DIGEST_2.0.20261128-0015-web-only := sha256:415d028b7c5c2f794a1bb941aed6042ab260056c9e29101f419267126b85fe84
BASE_IMAGE_DIGEST_2.0.20261128-0015-web-only-stable := sha256:c9d2b90ab068dbeb7f8671a63aa218e8cbe097ba491bebca7815d2651d3e57b1

# Fail before building when a version has no reviewed pin.
BASE_IMAGE = $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG)@$(or $(BASE_IMAGE_DIGEST_$(BASE_IMAGE_TAG)),$(error No base image digest for $(BASE_IMAGE_REPOSITORY):$(BASE_IMAGE_TAG); update base-images.mk))
