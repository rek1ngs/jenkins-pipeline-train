#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <environment_name>" >&2
  exit 1
fi

environment_name="$1"

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=jenkins/common.sh
source "$script_dir/common.sh"

ensure_command git
ensure_command node
ensure_command npm

echo "Running API tests for greetings_${environment_name}"
checkout_repo "$API_TEST_REPO_URL" "$API_TEST_BRANCH" "$API_TEST_DIR"

pushd "$API_TEST_DIR" >/dev/null
npm install
npm run greetings "greetings_${environment_name}"
popd >/dev/null
