# git init with repo templates
#
# Assumes templates are in ~/.gitconfig.d/templates, or GIT_INIT_TEMPLATES
#
# Usage: gi <template> [git init options...]
gi() {
  local tpl=$1
  shift

  tpl=${GIT_INIT_TEMPLATES:-~/.gitconfig.d/templates}/$tpl

  if [[ -d "$tpl" ]]; then
    git init --template=$tpl "$@"
  else
    echo "No such git template: $tpl"
    return 1
  fi
}

# Add a new git repo template with given config
#
# Usage: giadd <template> [git config options...]
giadd() {
  local tpl=$1
  shift

  tpl=${GIT_INIT_TEMPLATES:-~/.gitconfig.d/templates}/$tpl

  if [[ -d "$tpl" ]]; then
    echo "git template '$tpl' already exists"
    return 1
  fi

  git config --file=$tpl "$@"
}

# Show the template's config file
#
# Usage: gishow <template>
gishow() {
  local tpl=${GIT_INIT_TEMPLATES:-~/.gitconfig.d/templates}/$1

  if [[ -f "$tpl/config" ]]; then
    cat $tpl/config
  fi
}

_gicomplete() {
  local dir=${GIT_INIT_TEMPLATES:=~/.gitconfig.d/templates}
  local word=${COMP_WORDS[1]}

  COMPREPLY=()

  if [[ -d "$dir" ]]; then
    COMPREPLY=( $(basename -a ${dir}/${word}*) )
  fi
}

complete -F _gicomplete gi gishow
