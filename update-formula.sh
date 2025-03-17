#!/bin/bash

# Check if all parameters are provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 <formula_file> <version>"
  echo "Example: $0 git_contribution_stats.rb v1.3.0"
  exit 1
fi

FORMULA_FILE=$1
VERSION=$2

# Check if the formula file exists
if [ ! -f "$FORMULA_FILE" ]; then
  echo "Error: Formula file '$FORMULA_FILE' not found."
  exit 1
fi

# Extract the full repository path from the URL or homepage
if grep -q 'url "https://github.com/' "$FORMULA_FILE"; then
  REPO_URL=$(grep -o 'url "https://github.com/[^"]*' "$FORMULA_FILE" | head -1 | sed 's|url "https://github.com/||')
  # Extract the repo path from the URL (handle both archive links and direct repo links)
  if [[ "$REPO_URL" == *"/archive/"* ]]; then
    REPO=$(echo "$REPO_URL" | sed 's|/archive/.*||')
  else
    REPO="$REPO_URL"
  fi
elif grep -q 'homepage "https://github.com/' "$FORMULA_FILE"; then
  REPO=$(grep -o 'homepage "https://github.com/[^"]*' "$FORMULA_FILE" | head -1 | sed 's|homepage "https://github.com/||')
else
  echo "Error: Could not extract repository information from formula file."
  exit 1
fi

# Remove trailing slashes if present
REPO=$(echo "$REPO" | sed 's|/$||')

# Default to "tools" repository if not specified
if [[ "$REPO" != *"/"* ]]; then
  REPO="${REPO}/tools"
fi

URL="https://github.com/${REPO}/archive/refs/tags/${VERSION}.tar.gz"

# Download and calculate hash
echo "Downloading ${URL} and calculating SHA-256 hash..."
HASH=$(wget -qO- "${URL}" | shasum -a 256 | cut -d' ' -f1)

# Check if hash was successfully generated
if [ -z "$HASH" ]; then
  echo "Error: Failed to download or calculate hash."
  exit 1
fi

echo "Repository: ${REPO}"
echo "Version: ${VERSION}"
echo "SHA-256: ${HASH}"

# Update the formula file
echo "Updating formula file..."
# Update the URL
sed -i "s|url \"https://github.com/[^\"]*\"|url \"https://github.com/${REPO}/archive/${VERSION}.tar.gz\"|" "$FORMULA_FILE"
# Update the SHA-256
sed -i "s|sha256 \".*\"|sha256 \"${HASH}\"|" "$FORMULA_FILE"

echo "Formula file '$FORMULA_FILE' has been updated successfully."