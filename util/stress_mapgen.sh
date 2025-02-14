#!/bin/bash
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
gameid=${gameid:-devtest}
freecraft=$dir/../bin/freecraft
testspath=$dir/../tests
conf_server=$testspath/server.conf
worldpath=$testspath/world

run () {
	if [ -n "$PERF" ]; then
		perf record -z --call-graph dwarf -- "$@"
	else
		"$@"
	fi
}

[ -e "$freecraft" ] || { echo "executable $freecraft missing"; exit 1; }

rm -rf "$worldpath"
mkdir -p "$worldpath/worldmods"

settings=(sqlite_synchronous=0 helper_mode=mapgen)
[ -n "$PROFILER" ] && settings+=(profiler_print_interval=15)
printf '%s\n' "${settings[@]}" >"$testspath/server.conf" \

ln -s "$dir/helper_mod" "$worldpath/worldmods/"

args=(--config "$conf_server" --world "$worldpath" --gameid $gameid)
[ -n "$PROFILER" ] && args+=(--verbose)
run "$freecraft" --server "${args[@]}"
