#!/usr/bin/env bash

# Version aliases identify published releases; only primary tags publish images.
if [[ "${GITHUB_REF:-}" =~ ^refs/tags/.+-r[0-9]+$ ]]; then
    exit 0
fi

set -exo pipefail

if [[ "${GITHUB_REF}" == refs/heads/main || "${GITHUB_REF}" == refs/tags/* ]]; then
  # DISCOURSE_VER is a Discourse release, such as 2026.10.0. Images are
  # published per release line (2026.10), not per year, because the monthly
  # release and the ESR share a year.
  minor_ver="${DISCOURSE_VER%.*}"

  tags=("${minor_ver}")

  if [[ "${GITHUB_REF}" == refs/tags/* ]]; then
    image_revision="${GITHUB_REF##*/}"
    tags=("${minor_ver}-${image_revision}")
  elif [[ -n "${LATEST}" ]]; then
    tags+=("latest")
  fi

  for tag in "${tags[@]}"; do
    make buildx-imagetools-create IMAGETOOLS_TAG=${tag}
  done
fi
