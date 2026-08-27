#!/bin/bash
set -e

# Load from .env or .env.local if present and variable not set
if [ -z "$ARB_TRANSLATE_API_KEY" ]; then
  ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
  if [ -f "$ROOT_DIR/.env" ]; then
    set -a
    source "$ROOT_DIR/.env"
    set +a
  elif [ -f "$ROOT_DIR/.env.local" ]; then
    set -a
    source "$ROOT_DIR/.env.local"
    set +a
  fi
fi

# Check if a parameter was passed as fallback
if [ -z "$ARB_TRANSLATE_API_KEY" ]; then
  if [ -n "$1" ]; then
    export ARB_TRANSLATE_API_KEY="$1"
  else
    echo "Warning: ARB_TRANSLATE_API_KEY environment variable is not set."
    echo "Usage: ./scripts/translate.sh <YOUR_GEMINI_API_KEY>"
    echo "Or add ARB_TRANSLATE_API_KEY=YOUR_KEY to .env in project root."
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
