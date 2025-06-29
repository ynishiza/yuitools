#!/usr/bin/env bash

# Exit immediately if not in interactive mode.
# Otherwise, causes scp to fail.
# See https://unix.stackexchange.com/questions/18231/scp-fails-without-error
[[ $- == *i* ]] || return

MY_BIN="$HOME/.yui_bin"
TOOLS_YUI="$HOME/.yui_tools"
BASHRC_YUI="${TOOLS_YUI}/dotfiles/bashrc"
# shellcheck disable=SC2034
BASHRCBASE_PATH="$BASHRC_YUI/bashrc_base"

# usage: do [[ -n $IS_MAC ]] to check if is mac.
IS_MAC=$( uname | grep Darwin || echo '' )

_base_main() {
	echo "bash $BASH_VERSION" >&2
	echo "Loading ${BASH_SOURCE[0]}" >&2
	_base_setupOptions
	_base_setupEnv
	_base_setupAlias
	_base_setupPS1
	_base_setupFunction
	_base_setupTools

	## .env
	# Load if any.
	# IMPORTANT: load before tools, since .env may contain settings for the tools.
	[[ -f './.env' ]] && echo "Found .env. Exporting." >&2 && yt_DotEnvExport
	_base_loadTools
	_base_setupTools

	## Custom bashrc
	#
	# Do this last. Otherwise, may get overwritten by default.
	# shellcheck disable=SC1091
	[[ -n $IS_MAC ]] && source "$BASHRC_YUI/bashrc_mac.sh"
	# shellcheck disable=SC1091
	source "$BASHRC_YUI/bashrc_fzf.sh"
	# shellcheck disable=SC1091
	source "$BASHRC_YUI/bashrc_snort.sh"

	_yt_loadLocalBashrc
}

_base_setupOptions() {
	## shopt (shell options)
	#
	# See shopt under SHELL BUILTIN COMMANDS
	# e.g. !(
	shopt -s extglob
}

_base_loadTools() {
	## Tools
	#
	_loadSourceIfExist() {
		local source_path="$1"
		# shellcheck disable=SC1090
		[[ -f "$source_path" ]] && source "$source_path"
	}

	_loadSourceIfExist "${MY_BIN}/completion/git-completion.bash"
	_loadSourceIfExist "${MY_BIN}/completion/tmuxinator.bash"
	_loadSourceIfExist "${MY_BIN}/completion/stack.bash"
	_loadSourceIfExist "${MY_BIN}/completion/ghcup.bash"
}

_base_setupTools() {
	# GPG
	# GPG + SSH
	SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
	export SSH_AUTH_SOCK
	gpgconf --launch gpg-agent
	GPG_TTY=$(tty)
	export GPG_TTY

	yt_gpg_reload_all() {
		echo "Reloading: gpg-agent gpg dirmngr"
		sudo gpgconf --kill gpg-agent gpg dirmngr
		sleep 1
		sudo gpgconf --launch gpg-agent gpg dirmngr
	}

	# similar to sudo --validate
	# i.e. set cached password
	yt_gpg_validate() {
		echo a | gpg --sign -a > /tmp/.gpg_temp
	}

	# GPG_TTY:
	# Tell gpg-agent which tty to use.
	# See 'man gpg-agent'
	# # https://unix.stackexchange.com/questions/217737/pinentry-fails-with-gpg-agent-and-ssh
	yt_gpgagent_use_this_tty() {
		GPG_TTY=$(tty)
		export GPG_TTY
		echo "UPDATESTARTUPTTY" | gpg-connect-agent > /dev/null 2>&1
		echo "GPG_TTY=$GPG_TTY"
	}

	# fzf initialization
	# shellcheck disable=SC1090
	[ -f ~/.fzf.bash ] && source ~/.fzf.bash
}

_base_setupPS1() {
	## PS1
	#
	# See PROMPTING in man bash
	#
	# \s = Shell
	# \h = hostname
	# \H = Full hostname
	# \u = Current user
	# \w = Current directory from the user's home directory
	# \W = Current directory
	# shellcheck disable=SC2034
	BLACK="\[\e[30m\]"
	RED="\[\e[31m\]"
	# shellcheck disable=SC2034
	GREEN="\[\e[32m\]"
	# shellcheck disable=SC2034
	YELLOW="\[\e[33m\]"
	BLUE="\[\e[34m\]"
	# shellcheck disable=SC2034
	MAGENTA="\[\e[35m\]"
	# shellcheck disable=SC2034
	CYAN="\[\e[36m\]"
	WHITE="\[\e[37m\]"
	RESET="\[\e[0m\]"
	export PS1="${WHITE}\u${RESET}@${WHITE}\H${RESET}:${BLUE}\W${RESET} [j=${RED}\j${RESET}] >> "
}


_base_setupAlias() {
	alias pu="pushd"
	alias po="popd"
	alias ll="ls -alF"
	alias la="ls -A"
	alias rm="rm -i"
	alias cp="cp -i"
	alias mv="mv -i"
	alias killall="killall -I"

	alias yt_doublequote="sed -e 's/\(.*\)/\"\1\"/'"
	alias yt_singlequote="sed -e \"s/\(.*\)/'\1'/\""

	# To enable <C-S> to work in vim.
	alias vim="stty stop '' -ixoff; vim"

	# Cleanup swap files older than 1week
	# Ref: https://superuser.com/questions/480367/whats-the-easiest-way-to-delete-vim-swapfiles-ive-already-recovered-from
	alias yt_nvim_cleanswap="find ~/.local/state/nvim/swap -name \"*sw[klmnop]\" -atime +1w -delete"

	# Include local node_modules in path
	# https://stackoverflow.com/questions/9679932/how-to-use-package-installed-locally-in-node-modules
	alias yt_npm-exec='PATH=$(npm bin):$PATH'

	# Debug safely on an port
	alias yt_node-debug='node inspect --port=54325'

	# Only works if no values contain no spaces
	alias yt_dotenv-use="env \$(cat .env | grep -v '^#' | xargs)"
	alias yt_dotenv-export="export \$(cat .env | grep -v '^#' | xargs)"
}

_base_setupFunction() {
	yt_PrintSystemInfo() {
		echo "Bash:$SHELL $BASH_VERSION"
		echo "Date:$(date)"
		echo "Kernel:$(uname -a)"
		echo "User:$(whoami)"
		echo "Host:$(hostname)"
	}
	# Bug: printing here caused problems when uploading with scp.

	# shellcheck disable=SC2120
	yt_DotEnvExportBase() {
		local envname="${1:-.env}"
		[[ ! $# -eq 1 ]] && echo "Missing environment file" && usage && return 1

		local envname="$1"
		[[ ! -f "$envname" ]] && echo "Not a file: $envname" && return 1

		echo "yt_DotEnvExport $envname" >&2
		while read -r line
		do
			# Skip comment
			if echo "$line" | grep '^#' >/dev/null; then continue; fi
			# shellcheck disable=SC2163
			export "$line"
		done < "$envname"
	}
	yt_DotEnvExport() {
		yt_DotEnvExportBase "${1:-.env}"
	}

	yt_DotEnvExec() {
		local envfile=$1
		shift 1
		# shellcheck disable=SC2068,SC2119
		( yt_DotEnvExport "$envfile"; $@ )
	}
}


_base_setupEnv() {
	#
	# EDITOR: default editor
	if which nvim >/dev/null; then EDITOR=nvim; else EDITOR=vim; fi
	export EDITOR

	# LESS: default less options
	# -N 		line number
	# -M 		show file % + line number in status prompt
	# -J 		show status column on left
	export LESS="-N -J --save-marks --incsearch -M -F -R"

	_setupPath
}

_setupPath() {
	## Path
	#
	# Take backup so that if this bashrc is reloaded, we don't duplicate paths.
	[[ ! $PATH_BAK ]] && PATH_BAK=$PATH

	# Disabled: For some reason, PATH_BAK may be already set.
	# PATH=$PATH_BAK

	PATH=/usr/sbin:$PATH
	PATH=/usr/local/bin:/usr/local/sbin:/usr/sbin:$PATH
	PATH="$MY_BIN:$PATH"
	[[ -d "$HOME/bin" ]] && PATH="$HOME/bin:$PATH"
	[[ -d "$HOME/.bin" ]] && PATH=$HOME/.bin:$PATH
	export PATH_BAK
	export PATH
}

_setupCustomVariables() {
	# Nothing yet
	:
}

_yt_loadLocalBashrc() {
	# Load per-directory .bashrc, if any.
	local local_bashrc
	local_bashrc="$(pwd -P)/.bashrc";
	local home_bashrc="$HOME/.bashrc"

	# shellcheck disable=SC1090
	[[ -f "$local_bashrc" ]] && ! cmp -s "$local_bashrc" "$home_bashrc" \
		&& echo "Loading local $local_bashrc" >&2 \
		&& source "$local_bashrc"
}

_base_main
