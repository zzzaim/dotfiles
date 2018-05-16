# bin/bin/fuz aliases
alias ff='fuz -f'
alias fa='fuz -a'
alias ft='fuz -g'
alias vima='vimf -a'
alias vimg='vimf -g'

# Open files found using `fuz` program in vim tabs.
# With safeguards if more than 10 files found.
vimf() {
  files=( $(fuz "$@") )

  if [[ "${#files[@]}" -gt 10 ]]; then
    echo More than 10 files to edit >&2
    for n in "${files[@]}"; do
      echo $n
    done
    return 1
  fi

  vim -p "${files[@]}"
}
