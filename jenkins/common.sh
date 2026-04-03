#!/usr/bin/env bash
set -euo pipefail

readonly PYTHON_GREETINGS_REPO_URL="${PYTHON_GREETINGS_REPO_URL:-https://github.com/mtararujs/python-greetings.git}"
readonly PYTHON_GREETINGS_BRANCH="${PYTHON_GREETINGS_BRANCH:-main}"
readonly PYTHON_GREETINGS_DIR="${PYTHON_GREETINGS_DIR:-python-greetings-repo}"

readonly API_TEST_REPO_URL="${API_TEST_REPO_URL:-https://github.com/mtararujs/course-js-api-framework.git}"
readonly API_TEST_BRANCH="${API_TEST_BRANCH:-main}"
readonly API_TEST_DIR="${API_TEST_DIR:-course-js-api-framework-repo}"

ensure_command() {
  local command_name="$1"

  if ! command -v "$command_name" >/dev/null 2>&1; then
    echo "Missing required command: $command_name" >&2
    exit 1
  fi
}

checkout_repo() {
  local repo_url="$1"
  local branch="$2"
  local target_dir="$3"

  rm -rf "$target_dir"
  git clone --depth 1 --branch "$branch" "$repo_url" "$target_dir"
}
