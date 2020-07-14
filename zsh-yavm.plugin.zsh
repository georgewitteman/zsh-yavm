#!/usr/bin/env zsh

YAVM_PLUGIN_DIR="${0:a:h}/plugins"
YAVM_CONFIG_DIR="${YAVM_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/yavm}"
YAVM_DATA_DIR="${YAVM_INSTALL_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/yavm}"
YAVM_INSTALL_DIR="${YAVM_DATA_DIR}/installs}"

# echo "YAVM_PLUGIN_DIR: $YAVM_PLUGIN_DIR"
# echo "YAVM_CONFIG_DIR: $YAVM_CONFIG_DIR"
# echo "YAVM_DATA_DIR: $YAVM_DATA_DIR"
# echo "YAVM_INSTALL_DIR: $YAVM_INSTALL_DIR"

fpath+=("${0:a:h}/autoload")
autoload -Uz "${0:a:h}"/autoload/*

typeset -gA yavm_version_files
typeset -gA yavm_version_variables
typeset -gA yavm_default_version_files

# preexec_functions+=(yavm_set_path)
# chpwd_functions+=(yavm_set_path)
