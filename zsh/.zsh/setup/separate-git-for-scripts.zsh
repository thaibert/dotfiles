#!/usr/bin/env zsh

is-git() {
  cmd=( ${=1} )

  if [[ "$(basename "${cmd[1]}")" == "git" ]]; then
    export __USER_INITIATED_FOR_SURE="true"
  else
    export __USER_INITIATED_FOR_SURE="false"
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec is-git
