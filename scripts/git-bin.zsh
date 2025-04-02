#!/usr/bin/env zsh

DEFAULT_GIT_BIN='/usr/bin/git'

get-gitbin-file() {
  local RC_FILE=".gitbin"
  local potential="$RC_FILE"
  local normalised
  while [[ ! -f "$potential" ]]; do
    normalised="$(realpath "$potential")"
    if [[ "$normalised" == "/$RC_FILE" ]]; then
      potential="$HOME/.gitbin"
      break
    fi
    potential="../$potential"
  done
  echo "$(realpath $potential)"
}

git_bin=""
call-git() {
  if [[ "$1" == "which" ]]; then
    echo "$git_bin"
    exit 0
  fi

  "$git_bin" "$@"
  exit $?
}

is-script() {
  [[ "$__USER_INITIATED_FOR_SURE" == "true" ]] && echo "false" || echo "true"
}

################################################################################

if [[ "$(is-script)" == "true" ]]; then
  git_bin="/usr/bin/git"
  call-git "$@"
fi

gitbin_file="$(get-gitbin-file)"
if [[ ! -f "$gitbin_file" ]]; then
  git_bin="$DEFAULT_GIT_BIN"
  call-git "$@"
fi

gitbin_contents="$(cat "$gitbin_file" 2>/dev/null)"
if [[ ! -f "$gitbin_contents" ]]; then
  echo "WARNING: Non-existent git binary defined in $gitbin_file" >&2
  echo "         Defaulting to $DEFAULT_GIT_BIN" >&2
  git_bin="$DEFAULT_GIT_BIN"
  call-git "$@"
fi

git_bin="$gitbin_contents"
call-git "$@"

