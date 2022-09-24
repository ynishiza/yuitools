#!/usr/bin/env bash
#shellcheck disable=SC1090
set -eu -o pipefail
# set -o xtrace

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=1091
source "$__dir/setup_setting.sh"

# step: confirm
__installTools() {
	read -r -p "Install tools (fzf, nvm, autojump, tmuxinator)? (y/n)" response && [[ "$response" != "y" ]] && return

	(__installFzf || true)
	(__installAutojump || true)
	(__installTmuxinator || true)
	(__installNvm || true)
}

__installFzf() {
	echo "Installing fzf"
	# shellcheck disable=2230
	[[ -n $(which fzf) ]] \
		&& echo "fzf already installed. Skipping." && return

	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
}

__installNvm() {
	echo "Installing nvm"
	# note: `which nvm` does NOT work
	# Since nvm is not a command, but a function loaded through ~/.nvm/nvm.sh
	# See dotfiles/bashrc_base
	#
	# shellcheck disable=2230
	[[ -d "$HOME/.nvm" ]] \
		&& echo "nvm already installed. Skipping." && return
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
}

__installAutojump() {
	echo "Installing autojump"
	[[ -d ~/.autojump ]] \
		&& echo "autojump already installed. Skipping." && return

	echo "Installing autojump"
	git clone git://github.com/joelthelion/autojump.git /tmp/autojump
	pushd /tmp/autojump
	./install.py
	popd
}

__installTmuxinator() {
	echo "Installing tmuxinator"
	# shellcheck disable=2230
	[[ -n $(which tmuxinator) ]] \
		&& echo "tmuxinator already installed. Skipping." && return
	sudo gem install tmuxinator
}

__installTools
