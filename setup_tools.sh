#!/bin/bash
#shellcheck disable=SC1090
set -eu -o pipefail
# set -o xtrace

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dir/setup_setting.sh"

function installBrew() {
	if [[ ! -n $IS_MAC ]]; then return; fi;
	if [[ -n $(which brew) ]]; then return; fi;
	echo "Installing brew"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

function installFzf() {
	if [[ -n $(which fzf) ]]; then return; fi
	echo "Installing fzf"
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
}

function installAutojump() {
	if [[ -d ~/.autojump ]]; then return; fi

	echo "Installing autojump"
	git clone git://github.com/joelthelion/autojump.git /tmp/autojump
	pushd /tmp/autojump
	./install.py
	popd
}

function installTmuxinator() {
	if [[ -n $(which tmuxinator) ]]; then return; fi
	sudo gem install tmuxinator
}

(installBrew || true)
(installFzf || true)
(installAutojump || true)
(installTmuxinator || true)
