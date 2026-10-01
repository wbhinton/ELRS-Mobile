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

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# arb_translate 1.1.0 maps its model enum to the retired Gemini 1.5
# `-latest` names, and its config only accepts 1.5 names. Rewrite the
# mapping in the pub cache to current models, and fail loudly if the
# source no longer looks as expected (e.g. after a version bump) rather
# than silently calling a dead model.
ARB_TRANSLATE_VERSION="$(awk '/^  arb_translate:/{f=1} f&&/^    version:/{gsub(/[" ]|version:/,""); print; exit}' "$ROOT_DIR/pubspec.lock")"
if [ -z "$ARB_TRANSLATE_VERSION" ]; then
  echo "Error: could not read the arb_translate version from pubspec.lock."
  exit 1
fi
DELEGATE="${PUB_CACHE:-$HOME/.pub-cache}/hosted/pub.dev/arb_translate-$ARB_TRANSLATE_VERSION/lib/src/translation_delegates/gemini_translation_delegate.dart"
if [ ! -f "$DELEGATE" ]; then
  echo "Error: arb_translate source not found at $DELEGATE (run flutter pub get)."
  exit 1
fi
sed -i "s/Model.gemini15Pro || Model.gemini15Flash => '\${model.key}-latest'/Model.gemini15Pro => 'gemini-2.5-pro', Model.gemini15Flash => 'gemini-2.5-flash'/g" "$DELEGATE"
if ! grep -q "Model.gemini15Flash => 'gemini-2.5-flash'" "$DELEGATE"; then
  echo "Error: could not patch arb_translate $ARB_TRANSLATE_VERSION model mapping — its source has changed."
  exit 1
fi

echo "Clearing translations whose English source changed..."
node "$ROOT_DIR/scripts/arb_stale_check.js" invalidate

echo "Running arb_translate..."
dart run arb_translate

echo "Running markdown translation for assets..."
node "$(dirname "$0")/translate_markdown.js"

echo "Running website translation (Astro docs & UI)..."
node "$(dirname "$0")/../website/scripts/translate_astro.cjs"

echo "Running flutter gen-l10n..."
flutter gen-l10n

echo "Recording English source hashes..."
node "$ROOT_DIR/scripts/arb_stale_check.js" record

echo "Translation pipeline completed successfully!"
