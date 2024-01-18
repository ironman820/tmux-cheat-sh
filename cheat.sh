#!/usr/bin/env bash
if ! [ -e ~/.config/tmux/cht-langs ]; then
  echo "cpp|c|golang|lua|rust|typescript|javascript|nodejs|sql|zig|html|css|zsh|bash|python|tmux|gdb|radare2" | tr '|' '\n' > ~/.config/tmux/cht-langs
fi

if ! [ -e ~/.config/tmux/cht-utils ]; then
  echo "mv|sed|awk|git|ps|ssh|cargo|tr|jq|docker|docker-compose" | tr '|' '\n' > ~/.config/tmux/cht-utils
fi

open_info() {
  local query; \
    read -p "$(printf "Enter query for %s: " "$1")" query; \
  query=`echo $query | tr ' ' '+'`; \
  tmux neww bash -c "echo \"cht.sh /$1/$query\" & cht.sh /$1/$query; echo \"Press any key to continue\"; read -rsn1"; \
  exit 0
}

items="$(printf '%s|%s' $(cat ~/.config/tmux/cht-langs | tr '\n' '|') $(cat ~/.config/tmux/cht-utils | tr '\n' '|') |
    tr '|' '\n' |
    grep -v '^$' |
    sort -u
)"
[ -z "$items" ] && tmux display 'cht-sh: No languages or utilities found.' && exit

open_info "$(echo "$items" | fzf)"
