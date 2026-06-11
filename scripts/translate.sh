#!/bin/bash
set -e

# Load local API key if the environment variable isn't already set
if [ -z "$ARB_TRANSLATE_API_KEY" ]; then
  # Check if a local config file or parameter was passed
  if [ -n "$1" ]; then
    export ARB_TRANSLATE_API_KEY="$1"
  else
    echo "Warning: ARB_TRANSLATE_API_KEY environment variable is not set."
    echo "Usage: ./scripts/translate.sh <YOUR_GEMINI_API_KEY>"
    echo "Or run: export ARB_TRANSLATE_API_KEY=\"YOUR_KEY\" && ./scripts/translate.sh"
    exit 1
  fi
fi

echo "Running arb_translate..."
dart run arb_translate

echo "Running markdown translation for assets..."
node "$(dirname "$0")/translate_markdown.js"

echo "Running website translation (Astro docs & UI)..."
node "$(dirname "$0")/../website/scripts/translate_astro.cjs"

echo "Running flutter gen-l10n..."
flutter gen-l10n

echo "Translation pipeline completed successfully!"
