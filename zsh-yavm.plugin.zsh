#!/usr/bin/env zsh

fpath+=("${0:a:h}/autoload/")
autoload -Uz "${0:a:h}"/autoload/*

function yavm() {
  local cmd="$1"

  if [[ -z "$cmd" ]]; then
    yavm_help
    return "$status"
  fi

  shift

  local sub_script="yavm_${cmd/\-/_}"

  if (( ! $+functions[$sub_script] )); then
    _yavm_invalid_command "$cmd"
    return "$status"
  fi

  "$sub_script" "$@"
}

preexec_functions+=(yavm_set_path)
