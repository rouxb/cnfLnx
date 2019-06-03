#!/usr/bin/env bash

### Easier navigation: .., ..., ...., ....., ~ and -
alias ..="\cd .."
alias ...="\cd ../.."
alias ....="\cd ../../.."
alias .....="\cd ../../../.."


### Shortcuts
### git shortcuts
alias gits="git status"
alias gitd="git diff"
alias gitl="git log"
alias gitld="git log -p -n1"
alias gitc="git commit"
alias gita="git add"

### cd history alias
alias scd="pushd `pwd` &> /dev/null; popd &> /dev/null"
alias pcd="popd"
dcd(){
  echo "Dir stack contains: "
  for index in ${!DIRSTACK[*]}
  do
    printf "%4d: %s\n" $index ${DIRSTACK[$index]}
  done
}

### Nvim shortcuts
alias v="nvim"
alias vi="nvim"
alias vim="nvim"

### Alias for emacs
alias ec='emacs -nw'
alias ecw='emacs'

### Keyboard Layout toggle
dvp(){
    setxkbmap -layout us -variant dvp
    xmodmap -e "keycode 94 = eacute egrave"
    xmodmap -e "clear lock"
    xmodmap -e "keycode 66 = Super_L agrave"
}
alias azerty='setxkbmap -layout fr'
alias querty='setxkbmap -layout us'

### open in background
open() {
  nohup gvfs-open $@ &>/dev/null
}
alias o='open'

backLaunch() {
  nohup $@ &>/dev/null
}
alias bl='backLaunch'

### Zoom in urxvt 
zoom() {
    printf '\33]50;%s\007' "xft:DejaVuSansMonoForPowerLine:size=$1"
}

URXVT_SIZE=10
URXVT_PROGRESS_SIZE=2
zp() {
    URXVT_SIZE=$(echo "$URXVT_SIZE+$URXVT_PROGRESS_SIZE" | bc )
    zoom $URXVT_SIZE
}

zm() {
    URXVT_SIZE=$(echo "$URXVT_SIZE-$URXVT_PROGRESS_SIZE" | bc )
    zoom $URXVT_SIZE
}

###
# Alias for fast machine jumping
##############################
jt(){
    if ! [[ 1 -eq $# ]]; then
        echo "You should provide only one argument for target machine name"
    else
        ssh -Yt $myname@$machine
    fi
}

### Colored ls
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
	export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
else
	colorflag=""
fi

### ls shortcuts
alias ll="ls -lF ${colorflag}"
alias l="ls -laF ${colorflag}"
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'" # only dir
alias ls="command ls ${colorflag}"

### Colored grep outputs
# Note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

### Enable aliases to be sudo’ed
alias sudo='sudo '

### Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

### Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

### Get week number
alias week='date +%V'

### Taskwarrior alias
export rif="project:Rifyle_dig"

### Get per user process
alias wuser='ps hax -o user | sort | uniq -c'

### Vnc sessions management
alias vncs='vncserver -geometry 1920x1000'
alias vncl='vncserver -list'
alias vnck='vncserver -kill'

# IP addresses
#alias localip="ipconfig getifaddr en0"
#alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Show active network interfaces
#alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Trim new lines and copy to clipboard
#alias c="tr -d '\n' | pbcopy"


# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
#alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Kill all the tabs in Chrome to free up memory
# [C] explained: http://www.commandlinefu.com/commands/view/402/exclude-grep-from-your-grepped-output-of-ps-alias-included-in-description
#alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"

