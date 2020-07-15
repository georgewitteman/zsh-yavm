#!/usr/bin/env zsh
##!/bin/echo Please source

#if [[ ! $ZSH_EVAL_CONTEXT =~ :file$ ]]; then
#  echo "Please source $0."
#fi
#
zmodload zsh/datetime
autoload -U colors && colors

local runs="${1:-1000}"
echo "Runs: $runs"

typeset -U path
typeset -U fpath
fpath=()
path=()

source "${0:a:h:h}/zsh-yavm.plugin.zsh"
# source ../zsh-yavm.plugin.zsh
preexec_functions=()
chpwd_functions=()

# local plugins=("${YAVM_PLUGIN_DIR}"/*(/:t))
local plugins=(asdf-golang nodejs pyenv)

# Warm caches
for i in {1..100}; do
  yavm init "${plugins[@]}"
done

echo "Plugins: ${plugins}"

local start_time="$EPOCHREALTIME"
for i in {1..$runs}; do
  # YAVM_PLUGIN_DIR="/Users/georgewitteman/.config/zsh/plugins/zsh-yavm/plugins"
  # YAVM_CONFIG_DIR="${YAVM_CONFIG_DIR:-${XDG_CONFIG_HOME:-$HOME/.config}/yavm}"
  # YAVM_INSTALL_DIR="${YAVM_INSTALL_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/yavm/installs}"
  # fpath+=("/Users/georgewitteman/.config/zsh/plugins/zsh-yavm/autoload")
  # autoload -Uz "/Users/georgewitteman/.config/zsh/plugins/zsh-yavm"/autoload/*

  # source "${0:A:h}/minimal-setup.zsh"

  source "${0:A:h:h}/zsh-yavm.plugin.zsh"

  yavm init "${plugins[@]}"

  # yavm_set_path
done
local end_time="$EPOCHREALTIME"

local start_time_ms="$(( $start_time * 1000 ))"
local end_time_ms="$(( $end_time * 1000 ))"
local elapsed_ms="$(( $end_time_ms - $start_time_ms ))"
local per_run_ms="$(( $elapsed_ms / $runs ))"

local formatted_per_run_time="${${(s:.:)per_run_ms}[1]}.${(r:4::0:)${${(s:.:)per_run_ms}[2]}}"
echo "${bold_color}Time per run: ${formatted_per_run_time}ms${reset_color}"
