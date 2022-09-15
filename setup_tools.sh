#!/bin/bash
#shellcheck disable=SC1090
set -eu -o pipefail
# set -o xtrace

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dir/setup_setting.sh"

installFzf() {
	# shellcheck disable=2230
	if [[ -n $(which fzf) ]]; then return; fi
	echo "Installing fzf"
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
}

installNvm() {
	# shellcheck disable=2230
	if [[ -n $(which nvm) ]]; then return; fi
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
}

installAutojump() {
	if [[ -d ~/.autojump ]]; then return; fi

	echo "Installing autojump"
	git clone git://github.com/joelthelion/autojump.git /tmp/autojump
	pushd /tmp/autojump
	./install.py
	popd
}

installTmuxinator() {
	# shellcheck disable=2230
	if [[ -n $(which tmuxinator) ]]; then return; fi
	sudo gem install tmuxinator
}

(installFzf || true)
(installAutojump || true)
(installTmuxinator || true)
(installNvm || true)
