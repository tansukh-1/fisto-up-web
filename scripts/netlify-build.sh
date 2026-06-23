#!/usr/bin/env bash
set -euo pipefail

# Builds the web shell on Netlify. The Lynx app lives in a separate (private)
# repo, so we clone + build it here to produce main.web.bundle + static/, which
# this project's rsbuild `publicDir` then copies into dist/.
#
# Requires the Netlify env var GH_PAT: a GitHub token with read access to the
# fisto-up repo.

LYNX_DIR="../fisto-up"
LYNX_REPO="https://x-access-token:${GH_PAT}@github.com/tansukh-1/fisto-up.git"

echo "→ Cloning the Lynx app repo…"
rm -rf "$LYNX_DIR"
git clone --depth 1 "$LYNX_REPO" "$LYNX_DIR"

echo "→ Building the Lynx web bundle…"
( cd "$LYNX_DIR" && npm ci && npm run build )

echo "→ Building the web shell…"
npm run build
