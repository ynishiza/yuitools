#!/usr/bin/env bash

## --preview: show preview up to `head 100` lines
FZF_DEFAULT_OPTS="--preview='head -100 {}' --bind 'ctrl-alt-k:preview-up,ctrl-alt-j:preview-down' --history=$HOME/.fzf.history"
if  which fzf > /dev/null;
then
	export FZF_DEFAULT_OPTS
fi
