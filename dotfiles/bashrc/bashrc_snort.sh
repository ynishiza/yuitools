#!/usr/bin/env bash
echo "Loading ${BASH_SOURCE[0]}" >&2
if which snort >/dev/null
then
	# macOS Mojave snort workaround
	# Produces Segmentation fault: https://apple.stackexchange.com/questions/337792/macos-mojave-get-segmentation-fault-11-when-trying-to-run-airport
	yt_snort_run() {
		local args
		args="$@"
		# Restart on segmentation fault
		while { snort $args; [[ $? == 139 ]]; }
		do
			sleep 0.5
		done
	}
fi
