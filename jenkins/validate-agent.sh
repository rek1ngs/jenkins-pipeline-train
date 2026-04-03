#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=jenkins/common.sh
source "$script_dir/common.sh"

ensure_command git
ensure_command python3
ensure_command node
ensure_command npm
ensure_command pm2

node_major="$(node -p 'process.versions.node.split(".")[0]')"
if (( node_major < 20 )); then
  echo "Node.js 20 or newer is required, found $(node --version)" >&2
  exit 1
fi

echo "git: $(git --version)"
echo "python3: $(python3 --version)"
echo "node: $(node --version)"
echo "npm: $(npm --version)"
echo "pm2: $(pm2 --version)"
