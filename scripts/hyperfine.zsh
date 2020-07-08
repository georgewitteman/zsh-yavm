#!/usr/bin/env zsh

local shell="$(which zsh)"
local cmd=(
  hyperfine --style full --warmup 10 --shell "$shell"
  "source ${0:A:h}/minimal-setup.zsh" "$@"
)
echo "\$ ${(q-)cmd[@]}"
eval "${(q-)cmd[@]}"

cmd=(
  hyperfine --style full --warmup 10
  --shell "${0:A:h}/fake-zsh.zsh"
  "$@"
  "yavm init asdf-golang pyenv"
)
echo "\$ ${(q-)cmd[@]}"
eval "${(q-)cmd[@]}"
