#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=jenkins/common.sh
source "$script_dir/common.sh"

ensure_command git
ensure_command python3

echo "Creating Python virtual environment"
checkout_repo "$PYTHON_GREETINGS_REPO_URL" "$PYTHON_GREETINGS_BRANCH" "$PYTHON_GREETINGS_DIR"

pushd "$PYTHON_GREETINGS_DIR" >/dev/null
python3 -m venv venv
./venv/bin/python -m pip install -r requirements.txt
popd >/dev/null
