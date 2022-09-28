#!/usr/bin/env bash

NEWLINE=$'\n'
main() {
	echo "Loading ${BASH_SOURCE[0]}"
	_setupAlias
	_setupEnv
	_setupCustomVariables
	_setupTools
	_setupFunctions
}

_setupAlias() {
	#
	# Alias
	#
	yt_CommandWithLess() {
		COMMAND="$1"
		shift 1
		OPTIONS="$*"
		echo "$OPTIONS"
		FULL="$COMMAND $OPTIONS | less"
		eval "$FULL"
	}
	alias yt_macos_top="top -r -S -stats pid,command,cpu,mem,user,time,state,rprvt,vsize,vprvt,kprvt,kshrd,purg"
	alias ls="ls -G"
	alias ll="ls -alFG"		# G=color F=show type
	alias la="ls -AG"
	_PSCOLUMNS="pid,ppid,user,%cpu,%mem,rss,vsz,comm"
	alias yt_macos_pscpu="yt_macos_CommandWithLess ps -Ar -o $_PSCOLUMNS"
	alias yt_macos_psmem="yt_macos_CommandWithLess ps -Am -o $_PSCOLUMNS"
	alias yt_macos_psid="ps -Ao pid,ppid,pgid,rgid,user,uid,tt,command"
	alias yt_macos_shutdown="sudo /sbin/shutdown -h now"

	# Sar
	SARINTERVAL=$((10))
	SARCOUNT=$(((60 * 60 * 24) / SARINTERVAL ))		# A day
	DoSar() {
		TYPE=$1
		INTERVAL=$2
		COUNT=$3
		if [[ ! $INTERVAL ]]; then INTERVAL=$SARINTERVAL; fi
		if [[ ! $COUNT ]]
		then
			COUNT=$(( SARCOUNT ))
		fi
		sar "$TYPE $INTERVAL $COUNT"
	}
	alias yt_macos_saru="DoSar -u"
	alias yt_macos_sard="DoSar -d"
	alias yt_macos_sarn="DoSar \"-n DEV\""
}

_setupEnv() {
	#
	# Mac specific settings
	#
	#export TERM='xterm-color'
	#alias tmux="TERM=screen-256color-bce tmux"
	#alias tmux="tmux -2"

	# tmux
	# Need to set SHELL to set custom shell for tmux
	# Ref: https://github.com/tmux/tmux/issues/1278
	export BASH=/usr/local/bin/bash
	export SHELL="$BASH"

	# Allow forward search with Ctrl-S
	stty stop undef

	_setupPath
}

_setupPath() {
	PATH=/usr/lib:$PATH
	PATH=$HOME/local/bin:$PATH
	export PATH
}

_setupCustomVariables() {
	# Nothing yet
	:
}

_setupFunctions() {
	## Network interfaces
	#
	# Watch for open TCP ports
	yt_lsof_tcp_listen() {
		# shellcheck disable=SC2048,SC2086
		sudo lsof -itcp -T s -s tcp:listen -P $*
	}
	yt_lsof_tcp_listen_watch() {
		sudo lsof -itcp -T s -s tcp:listen -P -r 30
	}
	# Watch for open UDP ports
	yt_lsof_udp_listen() {
		# shellcheck disable=SC2048,SC2086
		sudo  lsof -iudp -T -P $*
	}
	yt_lsof_udp_listen_watch() {
		sudo  lsof -iudp -T -P -r 30
	}

	yt_macos_ps_ping() {
		[[ $# -lt 2 ]] && echo "Watch ps for process by the given patterns $NEWLINE $0 SLEEP PATTERN1 [PATTERN2 ...]" && return 1
		local sleep="$1"
		shift
		local -a patterns=("$@")

		while true
		do
			echo "$(date) pattern:${patterns[*]} sleep:$sleep s"
			# shellcheck disable=SC2009
			psvalue="$(ps -A -o comm | grep -v yt_macos_ps_ping)"

			for pattern in "${patterns[@]}"
			do
				echo "pattern:$pattern sleep:$sleep s"
				if ! echo "$psvalue" | grep "$pattern" | grep -v grep
				then
					yt_macos_notification "$(date +%H:%M:%S) No process $pattern" "process ping: $pattern" >/dev/null
				fi
			done

			sleep "$sleep"
		done
	}

	apache_log_dir="/var/log/apache2"
	## apachectl
	# Start/stop local http server
	yt_macos_apache_start() {
		sudo apachectl start
		echo "Watch for httpd start. Hit key to continue."
		read -r _
		yt_lsof_tcp_listen -r 5
	}
	yt_macos_apache_restart() {
		sudo apachectl restart
		echo "Watch for httpd start. Hit key to continue."
		read -r _
		yt_lsof_tcp_listen -r 5
	}
	yt_macos_apache_stop() {
		sudo apachectl stop
		echo "Watch for httpd stop. Hit key to continue."
		read -r _
		yt_lsof_tcp_listen -r 5
	}
	yt_macos_apache_log_access() {
		less +F -N "$apache_log_dir/access_log"
	}
	yt_macos_apache_log_error() {
		less +F -N "$apache_log_dir/error_log"
	}

	## mac_volume [0-10]
	# Adjust volume
	yt_macos_old_mac_volume() {
		local volume=$1
		if [ ! "$volume" -ge 0 ] || [ ! "$volume" -le 10 ]; then echo "mac_volume [0-10]"; return 1; fi

		sudo osascript -e "set Volume $volume"
	}

	## change volume
	yt_macos_setget_volume() {
		local name=setget_volume
		local volume=$1
		if [[ $# == 0 ]]
		then

			local volume
			volume="$(osascript -e 'output volume of (get volume settings)')"
			cat <<EOF
volume: ${volume}

$name				 Get volume
$name n			 Set volume n=0~100
EOF
			return 0
		fi

		osascript -e "set volume output volume ${volume}"
		echo "volume: ${volume}"
	}

	yt_macos_notification() {
		[[ $# -lt 1 ]] && echo "Create macos notification$NEWLINE yt_mac_notification MESSAGE [TITLE]" && return 1
		local message="$1"
		local title="${2:-notification}"

		if which terminal-notifier
		then
			terminal-notifier -message "$message" -title "$title"
		else
			osascript -e "display notification \"$message\" with title \"$title\""
		fi
	}
}

_setupTools() {
	## Tools
	# iterm
	# shellcheck disable=SC1090,SC2046,SC2006,SC2086
	[[ -s ~/.iterm2_shell_integration.`basename $SHELL` ]] && source ~/.iterm2_shell_integration.`basename $SHELL`

	# bash-completion installed via Homebrew
	# shellcheck disable=SC1091
	[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

	# Homebrew
	#
	# HOMEBREW_NO_INSTALL_CLEANUP
	# Ref: https://docs.brew.sh/Manpage
	# By default, `brew cleanup` deletes old versions.
	# In particular, brew runs 'brew cleanup' after install/upgrade i.e. removes old version files
	# Disable this.
	export HOMEBREW_NO_INSTALL_CLEANUP=1			

	# HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK
	# Ref: https://docs.brew.sh/Manpage
	# By default, after an install brew checks if other install formulas have been affected by the install due to dependency changes
	# and tries to automatically upgrade those affected.
	# Disable this .
	export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1

	# autojump
	# shellcheck disable=SC1090
	[[ -s ~/.autojump/etc/profile.d/autojump.sh ]] && source ~/.autojump/etc/profile.d/autojump.sh

	# z
	# shellcheck disable=SC1090
	[[ -s ~/.z.sh ]] && source ~/.z.sh

	# iTerm
	# shellcheck disable=SC1091
	test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

	# Stubby
	if [[ -d /usr/local/opt/stubby ]]
	then
		# Stubby helpers
		yt_stubby_setdns() {
			# shellcheck disable=SC2068
			sudo bash /usr/local/opt/stubby/sbin/stubby-setdns-macos.sh $@
		}
		yt_stubby_log() {
			# shellcheck disable=SC2068
			sudo less $@ /usr/local/var/log/stubby/stubby.log
		}
		yt_stubby_server_key() {
			local host
			local port
			host=$1
			port=${2:-853}
			certificate=$(echo "" | openssl s_client -connect "${host}:${port}" 2>/dev/null)
			if [[ ! "$certificate" ]]; then echo "No certificate for ${host}:${port}"; return; fi
			echo "$certificate" |
				openssl x509 -pubkey -noout |
				openssl pkey -pubin -outform der |
				openssl dgst -sha256 -binary |
				openssl enc -base64
		}
	fi

	## gpg
	# Need to set GPG_TTY to get password prompt for ssh
	# https://unix.stackexchange.com/questions/217737/pinentry-fails-with-gpg-agent-and-ssh
	GPG_TTY=$(tty)
	export GPG_TTY
}

main
