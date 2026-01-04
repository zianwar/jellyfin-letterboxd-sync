#!/bin/bash
set -e

# Prompt for version
read -p "Enter version to release (e.g., v0.1.0): " VERSION

if [[ -z "$VERSION" ]]; then
  echo "Error: Version is required."
  exit 1
fi

# Add and commit changes
git add .
git commit -m "Refactor project structure and add publishing workflow" || echo "Nothing to commit, proceeding..."

# Create tag and push
git tag "$VERSION"
git push origin "$VERSION"

# Create GitHub release
gh release create "$VERSION" --generate-notes

echo "Release $VERSION created successfully!"
