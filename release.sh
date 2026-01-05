#!/bin/bash
set -e

# Extract version from pyproject.toml
VERSION="v$(grep -m1 'version = ' pyproject.toml | cut -d '"' -f 2)"

if [[ -z "$VERSION" ]]; then
  echo "Error: Could not extract version from pyproject.toml"
  exit 1
fi

echo "Releasing version: $VERSION"
read -p "Continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
fi

# Add and commit changes
git add .
git commit -m "Bump version to $VERSION" || echo "Nothing to commit, proceeding..."

# Create tag and push
git tag "$VERSION"
git push origin main
git push origin "$VERSION"

# Create GitHub release
gh release create "$VERSION" --generate-notes

echo "Release $VERSION created successfully!"
