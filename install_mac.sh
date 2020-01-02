#!/bin/bash
# shellcheck disable=SC1090
set -o errexit
set -o pipefail
set -o nounset

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dir/setup_setting.sh"

LOGFILE="/tmp/$0.log"

installBrew() {
	if [[ -z $IS_MAC ]]; then return; fi;
	# shellcheck disable=2230
	if [[ -n $(which brew) ]]; then return; fi;
	echo "Installing brew"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

installBrewPackages() {
	echo Logs in "$LOGFILE"
	echo $'\n'"$(date)" >> "$LOGFILE"
	brew update >> "$LOGFILE"
	export HOMEBREW_NO_INSTALL_CLEANUP=1

	# List of installed packages.
	# Delimited by '%' symbol to find substring.
	local installedPkgs
	installedPkgs=$(brew list)
	installedPkgs="%${installedPkgs//[[:space:]]/%}%"

	local toInstallPkgs=(
		# Essential
		cmake
		gdb
		git
		gnupg # gnupg2
		make
		pstree
		python@2 # python2
		python # python3
		pyenv
		pyenv pyenv-virtualenv
		pinentry-mac # password entry for gnupg
		libressl
		reattach-to-user-namespace

		# Tools
		autojump
		fzf
		htop
		iftop
		libressl
		pinentry-mac
		ncdu
		netcat
		nmap
		snort pulledpork
		shellcheck
		stubby
		tmux tmuxinator
		watchman

		# Misc
		jq
		youtube-dl
		redis
	)

	# Install packages
	for pkg in "${toInstallPkgs[@]}"
	do
		if [[ $installedPkgs == *"%$pkg%"* ]]
		then
			echo "$pkg is already installed." | tee -a "$LOGFILE"
			continue
		fi

		echo "Installing $pkg" | tee -a "$LOGFILE"
		brew install "$pkg" >> "$LOGFILE"
	done

	# Services
	brew services start stubby

	# Pin
	brew pin python python@2

	echo Logs in "$LOGFILE"
}

installBrew
installBrewPackages
