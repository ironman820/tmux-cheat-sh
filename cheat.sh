#!/usr/bin/env bash
if ! [ -e ~/.config/tmux/cht-langs ]; then
  echo "cpp|c|golang|lua|rust|typescript|javascript|nodejs|sql|zig|html|css|zsh|bash|python|tmux|gdb|radare2" | tr '|' '\n' > ~/.config/tmux/cht-langs
fi

if ! [ -e ~/.config/tmux/cht-utils ]; then
  echo "mv|sed|awk|git|ps|ssh|cargo|tr|jq|docker|docker-compose" | tr '|' '\n' > ~/.config/tmux/cht-utils
fi

get_fzf_options() {
    local cht_options
    local cht_default_options='-d 35% -m -0 --no-preview --no-border'
    cht_options="$(tmux show -gqv '@cheat-sh-options')"
    [ -n "$cht_options" ] && echo "$cht_options" || echo "$cht_default_options"
}

fzf_filter() {
  eval "fzf-tmux $(get_fzf_options)"
}

limit='screen'
[[ $# -ge 2 ]] && limit=$2

if [[ $limit == 'screen' ]]; then
    content="$(tmux capture-pane -J -p)"
else
    content="$(tmux capture-pane -J -p -S -"$limit")"
fi

if [[ $# -ge 1 && "$1" != '' ]]; then
    extras=$(echo "$content" |eval "$1")
fi

open_info() {
  local query
  read -p "Enter Query: " query

  query=`echo $query | tr ' ' '+'`
  tmux neww bash -c "echo \"cht.sh $1/$query\" & cht.sh $1/$query; echo \"Press any key to continue\"; read -rsn1"
  exit 0
}

items="$(printf '%s|%s' $(cat ~/.config/tmux/cht-langs | tr '\n' '|') $(cat ~/.config/tmux/cht-utils | tr '\n' '|') |
    grep -v '^$' |
    tr '|' '\n' |
    sort -u |
    nl -w3 -s '  '
)"
[ -z "$items" ] && tmux display 'cht-sh: No languages or utilities found.' && exit

open_info "$(fzf_filter <<< "$items" | awk '{print $2}')"
