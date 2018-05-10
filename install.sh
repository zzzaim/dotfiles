#!/usr/bin/env bash

set -eu

DRY=
PARAM=
TARGET=$HOME

for p in "$@"; do
  case "$p" in
    -n|--no|--simulate)
      DRY=echo
      ;;
    -t|--target)
      PARAM=target
      ;;
    *)
      if [[ "$PARAM" == target ]]; then
        TARGET="$p"
        PARAM=
      fi
      ;;
  esac
done

# target must be an absolute path
if [[ "${TARGET:0:1}" != '/' ]] ; then
  echo "Target must be an absolute path"
  exit 1
fi

# assume install.sh is in the root of the stow directory
cd $(dirname $0)

_stow() {
  $DRY stow -t $TARGET --ignore='^.stow-.*' --ignore='README.*' $@
}

for pkg in *; do
  # check if it is a pkg directory
  if [[ ! -d $pkg ]]; then
    continue
  fi

  # if there is a .stow-skip file, don't do anything
  if [[ -f "$pkg/.stow-skip" ]]; then
    continue
  fi

  # if there is a .stow-disabled file, delete existing pkg
  if [[ -f "$pkg/.stow-disabled" ]]; then
    _stow -D $pkg
    continue
  fi

  _stow $pkg
done
