#!/usr/bin/env zsh

YAVM_PLUGINS_DIR="${0:a:h}/plugins"

fpath+=("${0:a:h}/autoload/")
autoload -Uz "${0:a:h}"/autoload/*

# preexec_functions+=(yavm_set_path)
precwd_functions+=(yavm_set_path)
