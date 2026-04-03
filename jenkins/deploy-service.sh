#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <environment_name> <port>" >&2
  exit 1
fi

environment_name="$1"
port="$2"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=jenkins/common.sh
source "$script_dir/common.sh"

ensure_command git
ensure_command python3
ensure_command pm2

echo "Deploying greetings-app-${environment_name} on port ${port}"
checkout_repo "$PYTHON_GREETINGS_REPO_URL" "$PYTHON_GREETINGS_BRANCH" "$PYTHON_GREETINGS_DIR"

pushd "$PYTHON_GREETINGS_DIR" >/dev/null
pm2 delete "greetings-app-${environment_name}" || true
python3 -m venv venv
./venv/bin/python -m pip install -r requirements.txt
pm2 start ./venv/bin/python --name "greetings-app-${environment_name}" -- app.py --port "$port"
popd >/dev/null

pm2 save
