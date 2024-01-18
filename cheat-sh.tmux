#!/usr/bin/env bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# $1: option
# $2: default value
tmux_get() {
  local value
  value="$(tmux show -gqv "$1")"
  [ -n "$value" ] && echo "$value" || echo "$2"
}

key="$(tmux_get '@cheat-sh-bind' 'i')"

tmux bind-key "$key" display-popup -E "$SCRIPT_DIR/cheat.sh";
