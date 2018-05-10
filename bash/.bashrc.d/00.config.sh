# Too keep all config in one place.
# Only put environment variables here, not bash logic.

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# For setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Global options to for all ls aliases
LS_OPTS='-hX --file-type --hide=*.pyc --hide=node_modules --color=auto --group-directories-first'

# Path to prepend to Windows drive directories.
# in WSL, it's "/mnt", e.g. "/mnt/c/Windows",
# in CYGWIN/MSYS, it's "", e.g. just "/c/Windows"
WIN_MNT=/mnt

# Normal prompt
PS1_PROMPT='\w\n$ '

# Prompt when root (add for other users with PS1_PROMPT_${username})
PS1_PROMPT_root='\u \w\n# '

# Base16 color scheme (TODO: move base16 to own package)
BASE16_SHELL=~/.config/base16-shell

# vim: ft=sh
