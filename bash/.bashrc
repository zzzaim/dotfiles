# ~/.bashrc: executed by bash(1) for non-login shells.
# this is based on the default .bashrc from an Ubuntu distro
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Assume we are using the '.files/bash' stow package.
# Print warning if otherwise
if [ ! -d ~/.bashrc.d ]; then
  echo 'WARNING: Missing ~/bashrc.d directory, are you using your .files stow?'
fi

for n in ~/.bashrc.d/*; do
  source $n
done

unset n
