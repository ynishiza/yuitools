#!/bin/bash
set -eu -o pipefail

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cat "$__dir/yt_bashtemplate_code"
