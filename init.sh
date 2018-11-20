#!/usr/bin/env bash
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
### 
# Export .dotfiles as simlink
################################################################################

### Bash config {{{
bashrc_config=bash/bashrc
bashrc_trgt_path=~/.bashrc
ln -i -s $SCRIPTPATH/$bash_config $bash_trgt_path
inputrc_config=bash/inputrc
inputrc_trgt_path=~/.inputrc
ln -i -s $SCRIPTPATH/$inputrc_config $inputrc_trgt_path
### }}}

### Zsh config {{{
# zsh_config=zsh/zshrc
# zsh_trgt_path=~/.zshrc
# ln -i -s $SCRIPTPATH/$zsh_config $zsh_trgt_path
### }}}

### Submodules configuration {{{
# Vim and tmux config
./cnfNvimux/cnfLoad.sh
# Awesome config
./cnfAwesome/cnfLoad.sh
### }}}

### I3 config {{{
i3_config=i3
i3_trgt_path=~/.config/i3
ln -i -s $SCRIPTPATH/$i3_config $i3_trgt_path
### }}}

### Xresources config {{{
urxvt_config=urxvt/Xresources
urxvt_trgt_path=~/.Xresources
ln -i -s $SCRIPTPATH/$urxvt_config $urxvt_trgt_path
### }}}

### Zathura config {{{
zathura_config=pdf/zathurarc
zathura_trgt_path=~/.config/zathura/zathurarc
ln -i -s $SCRIPTPATH/$zathura_config $zathura_trgt_path
### }}}

### luakit config {{{
mkdir -p ~/.config/luakit
luakit_config=luakit/userconf.lua
luakit_trgt_path=~/.config/luakit/userconf.lua
ln -i -s $SCRIPTPATH/$luakit_config $luakit_trgt_path
### }}}

# vim: fdm=marker ts=2 sts=2 sw=2 fdl=0
