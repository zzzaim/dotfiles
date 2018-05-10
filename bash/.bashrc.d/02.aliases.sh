# Interactive operation...
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Default to human readable figures
alias df='df -h'
alias du='du -h'

# Some shortcuts for different directory listings
alias ls="ls $LS_OPTS"
alias la='ls -A'
alias ll='ls -l'
alias lt='ls -lt'
alias lv='ls -lv'
alias lla='ls -lA'
alias llv='ls -lAv'
alias lal=lla
alias lvl=llv
alias l=ls

# Git
alias g=git
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gd='git diff'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gl='git log'
alias gp='git push'
alias gs='git status'

# cd
alias cd-='cd -'
alias cd..='cd ..'
alias ..='cd ..'

# mkdir
alias mkdir='mkdir -pv'

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Windows programs
alias mpv='${WIN_MNT}/d/Zaim/Programs/mpv-i686-20161225/mpv.exe --quiet'
alias chrome='${WIN_MNT}/c/Program Files (x86)/Google/Chrome/Application/chrome.exe'

# misc
alias json='python -m json.tool'

# Generate random string
rdstr() {
  local s=$(uuidgen | tr -d -)
  if [ -n "$1" ]; then
    echo $s | cut -c -$1
  else
    echo $s
  fi
}

# Touch a file, creating parent folders if necessary
touchp() {
  if [ -n "$1" ]; then
    mkdir -p $(dirname $1)
    touch $1
  fi
}

# vim: ft=sh
