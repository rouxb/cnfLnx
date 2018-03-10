#!/usr/bin/env bash
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"
### 
# Export .dotfiles as simlink
################################################################################

### Bash config
bash_config=bash/bashrc
bash_trgt_path=~/.bashrc
ln -i -s $SCRIPTPATH/$bash_config $bash_trgt_path

### Zsh config
zsh_config=zsh/zshrc
zsh_trgt_path=~/.zshrc
ln -i -s $SCRIPTPATH/$zsh_config $zsh_trgt_path

### Vim config
mkdir -p ~/.config/nvim/
nvim_config=vim/init.vim
nvim_trgt_path=~/.config/nvim/init.vim
ln -i -s $SCRIPTPATH/$nvim_config $nvim_trgt_path

### Spacemacs config
spacemacs_config=emacs/spacemacs
spacemacs_trgt_path=~/.spacemacs
ln -i -s $SCRIPTPATH/$spacemacs_config $spacemacs_trgt_path

### I3 config
i3_config=i3/config
i3_trgt_path=~/.config/i3/config
ln -i -s $SCRIPTPATH/$i3_config $i3_trgt_path

### Tmux config
tmux_config=tmux/tmux.conf
tmux_trgt_path=~/.tmux.conf
ln -i -s $SCRIPTPATH/$tmux_config $tmux_trgt_path
