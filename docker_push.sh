#!/usr/bin/env bash

# Exit on any error
set -euo pipefail

# Registry prefix and version
REGISTRY_PREFIX="harbor.aimotive.com/lali-scheduler"
: "${VERSION:=0.0.7}"


echo "🔍 Searching for local images matching ${REGISTRY_PREFIX}/*:${VERSION}..."

# Get all matching image names
images=$(docker images --format '{{.Repository}}:{{.Tag}}' | grep "^${REGISTRY_PREFIX}/.*:${VERSION}" || true)

if [[ -z "$images" ]]; then
  echo "⚠️  No matching images found for ${REGISTRY_PREFIX}/*:${VERSION}"
  exit 0
fi

echo "📦 Found the following images:"
echo "$images"

# Loop through and push each image
for image in $images; do
  echo "🚀 Pushing $image ..."
  docker push "$image"
done

echo "✅ All matching images have been pushed successfully."
