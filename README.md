# tmux-cheat-sh

## Installation

### Requirements:
- [cht.sh](https://github.com/chubin/cheat.sh?tab=readme-ov-file#command-line-client-chtsh)
- [fzf](https://github.com/junegunn/fzf/)

### Install via [TPM](https://github.com/tmux-plugins/tpm/)
Add the following to `~/.tmux.conf`

```tmux
set -g @plugin 'ironman820/tmux-cheat-sh'
```

## Usage
The default key to open the popup is `PREFIX` + `i`. This can be modified by adding the following line to `~/.tmux.conf`
```tmux
set -g @cheat-sh-bind "/"
```
This changes the key to open the popup to `PREFIX` + `/`

## Adding or Removing language and util options
The options that appear on the popup can be chosen by modifying the files `~/.config/tmux/cht-langs` and `~/.config/tmux/cht-utils` respectively. These files are generated on the first run of the plugin with the following defaults:

`~/.config/tmux/cht-langs`
```text
cpp
c
golang
lua
rust
typescript
javascript
nodejs
sql
zig
html
css
zsh
bash
python
tmux
gdb
radare2
```

`~/.config/tmux/cht-utils`
```txt
mv
sed
awk
git
ps
ssh
cargo
tr
jq
docker
docker-compose
```

When updating the files, please place each language/util on it's own separate line.

## Acknowledgements 
- Based on this [ThePrimeagen video](https://www.youtube.com/watch?v=hJzqEAf2U4I)
- These amazing plugins were used as references:
  - [tmux-fzf](https://github.com/sainnhe/tmux-fzf)
  - [skrewby/tmux-cheat-sh](https://github.com/skrewby/tmux-cheat-sh)
