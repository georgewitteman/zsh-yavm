#!/usr/bin/env zsh

YAVM_PLUGIN_DIR="${0:a:h}/plugins"
YAVM_CONFIG_DIR="${YAVM_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/yavm}"
YAVM_INSTALL_DIR="${YAVM_INSTALL_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/yavm/installs}"

fpath+=("${0:a:h}/autoload/")
autoload -Uz "${0:a:h}"/autoload/*

preexec_functions+=(yavm_set_path)
# chpwd_functions+=(yavm_set_path)
