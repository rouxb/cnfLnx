#!/usr/bin/env bash
### Tmux setup function with template configuration ###########################

TMUX_TEMPLATE=("nvim" "md")
TMUX_DEFAULT_TEMPLATE="nvim"

usage() {
  echo "Script to create tmux template"
  echo "Usage : $PROG_NAME trgt_template session_name"
  echo " "
  echo "Arguments : "
  echo "  + trgt_template: available [${TMUX_TEMPLATE[@]}]"
  echo "  + session_name."
}

# template_exist() {
#   local e match="$1"
#   shift
#   for e; do [[ "$e" == "$match" ]] && return 0; done
#   return 1
# }

template_create(){
  case "$1" in
    "nvim")
      tmux new-session -d -s $2_$1 -n 'Sandbox'
      tmux new-window -n 'Nvim' nvim
      tmux select-window -t :=0
      ;;
    "md")
      tmux new-session -d -s $2_$1 -n 'Sandbox'
      tmux new-window -n 'Nvim' nvim
      tmux select-window -t :=0
      ;;
    *)
      echo "Error Bad template arguments"
      usage
      ;;
  esac
}

tmux_new() {
  echo $#
if [[ 2 -eq $# ]]; then
    template=${1%/}
    session=${2%/}
    template_create $template $session
else
  echo "Error Bad number of arguments"
  usage
  exit 1
fi
}

alias tmuxT='tmux_new'
alias tmuxN='tmux_new nvim'
