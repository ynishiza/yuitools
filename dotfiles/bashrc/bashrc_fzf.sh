#!/usr/bin/env bash
FZF_DEFAULT_OPTS="--preview='head -100 {}' --bind 'ctrl-alt-k:preview-up,ctrl-alt-j:preview-down' --history=$HOME/.fzf.history"
if  which fzf > /dev/null;
then
	export FZF_DEFAULT_OPTS
fi
