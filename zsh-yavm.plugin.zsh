#!/usr/bin/env zsh

fpath+=("${0:a:h}/autoload/")
autoload -Uz "${0:a:h}"/autoload/*

preexec_functions+=(yavm_set_path)
