#!/usr/bin/env bash
set -euo pipefail
echo "Running devcontainer post-create setup..."

# Create Python venv
python3 -V || { echo "python3 not found"; exit 1; }
python3 -m venv .venv
# shellcheck disable=SC1091
source .venv/bin/activate
python -m pip install --upgrade pip

# Install backend and ai dependencies (if files exist)
if [ -f backend/requirements.txt ]; then
  pip install -r backend/requirements.txt || true
fi
if [ -f ai/requirements.txt ]; then
  pip install -r ai/requirements.txt || true
fi

# Run quick python syntax checks
python -m py_compile backend/backend/main.py || true
python -m py_compile ai/ai_engine/cli.py || true

# Flutter smoke check
if command -v flutter >/dev/null 2>&1; then
  echo "Flutter found:" $(flutter --version)
  echo "Running flutter pub get in app/ (if pubspec.yaml exists)"
  if [ -f app/pubspec.yaml ]; then
    (cd app && flutter pub get) || true
  fi
else
  echo "Flutter not installed in container"
fi

echo "Devcontainer setup complete. See README.md for next steps."
