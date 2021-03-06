# node env colors
declare -A PS1_node_env_colors
PS1_node_env_colors[development]="$eDarkgray"
PS1_node_env_colors[production]="$eGreen"
PS1_node_env_colors[staging]="$eYellow"

PS1_prompt_var=PS1_PROMPT_$USER
PS1_prompt=${!PS1_prompt_var:-$PS1_PROMPT}
PS1=$PS1_prompt

# https://gist.github.com/wolever/6525437
#
# prompt examples:
#   [3 jobs master virtualenv] ~/code/myproject/foo
#   [1 job my-branch virtualenv] ~/code/bar/
#   [virtualenv] ~/code/
#   ~
#
# 100% pure Bash (no forking) function to determine the current git branch
# Very, very fast, only requiring a couple of fork()s (and no forking at all
# to determine the current git branch)
_PS1_git_branch() {
  export GIT_BRANCH="" GIT_STATUS="" GIT_REPO=""

  local repo=""
  local gitdir=""
  local head=""
  local branch=""
  local submod=""
  local status=""
  local cur="$PWD"

  # find the current git repository (if any)
  while [[ ! -z "$cur" ]]; do
    if [[ -e "$cur/.git" ]]; then
      repo="$cur"
      gitdir="$cur/.git"
      break
    fi
    cur="${cur%/*}"
  done

  # not in a git repo, return
  if [[ -z "$gitdir" ]]; then
    return 0
  fi

  # .git is a plain file, maybe it's a submodule?
  if [[ -f "$gitdir" ]]; then
    read gitdir < "$gitdir"
    gitdir="${gitdir##gitdir: }"
    submod='(m)'

    # not a submodule, return
    if [[ -z "$gitdir" || ! -f "$gitdir/HEAD" ]]; then
      return 0
    fi
  fi

  if [[ -f "$gitdir/HEAD" ]]; then
    # get git HEAD without using a git command
    read head < "$gitdir/HEAD"

    case "$head" in
      ref:*)
        branch="${head##*/}"
        ;;
      "")
        branch=""
        ;;
      *)
        branch="d:${head:0:7}"
        ;;
    esac
  fi

  # no branch? return
  if [[ -z "$branch" ]]; then
    return 0
  fi

  # get git status
  # this is slightly faster than `git status --porcelain`
  status=$(cd $repo && git ls-files -domu --exclude-standard --directory --no-empty-directory 2>/dev/null)

  # just want dirty state, not list of files
  [[ -n "$status" ]] && status=1

  # auto set GIT_SSH_COMMAND
  # this for when using git<2.10, which doesn't support core.sshCommand config
  export GIT_SSH_COMMAND=$(git config -f $gitdir/config core.sshCommand 2>/dev/null)

  # export all relevant vars
  export GIT_REPO="$repo"
  export GIT_STATUS="$status"
  export GIT_BRANCH="${branch}${submod}"
}

_PS1_node_version() {
  local ver=""
  local pkg=""
  local cur=""

  # check if there is node installed
  if type node &>/dev/null; then
    cur="$PWD"
    ver="$(node --version|cut -d. -f1)"
    ver="${ver:1}"

    # find current node package.json, if any
    while [[ ! -z "$cur" ]]; do
      if [[ -e "$cur/package.json" ]]; then
        pkg=1
        break
      fi
      cur="${cur%/*}"
    done
  fi

  export NODE_VER="$ver"
  export NODE_PKG="$pkg"
}

_PS1_term_title() {
  local term_title="${1:-$PWD}"

  case $TERM in
    xterm*|rxvt*|Eterm)
      echo -ne "\033]0;${term_title}\007"
      ;;
    screen)
      echo -ne "\033_${term_title}\033\\"
      ;;
  esac
}

_PS1_prompt() {
  local prefix=()
  local jobcount="$(jobs -p | wc -l)"
  local git_color="${eBlue}"
  local node_env="${NODE_ENV:-development}"
  local node_color=${PS1_node_env_colors[$node_env]:-$eDarkgray}
  local virtualenv="${VIRTUAL_ENV##*/}"

  _PS1_term_title "$(dirs)"
  _PS1_node_version
  _PS1_git_branch

  if [[ "$PS1_COMMAND_ERROR" -gt 0 ]]; then
    prefix+=("$(Black lightred) $PS1_COMMAND_ERROR ${eend}")
  fi

  if [[ "$jobcount" -gt 0 ]]; then
    prefix+=("${eDarkgray}[${jobcount##* }]${eend}")
  fi

  if [[ "$GIT_STATUS" -eq 1 ]]; then
    git_color="$eRed"
  fi

  if [[ -n "$GIT_BRANCH" ]]; then
    prefix+=("${git_color}$GIT_BRANCH${eend}")
  fi

  if [[ -n "$NODE_VER" ]]; then
    prefix+=("${node_color}v${NODE_VER}${eend}")
  fi

  if [[ "$NODE_PKG" -eq 1 ]]; then
    prefix+=("${node_color}${node_env}${eend}")
  fi

  if [[ -n "$virtualenv" ]]; then
    prefix+=("${eCyan}$virtualenv${eend}")
  fi

  PS1="$PS1_prompt"
  if [[ "${#prefix[@]}" -gt 0 ]]; then
    PS1="${prefix[@]} $PS1_prompt"
  fi

  export PS1
}

export PROMPT_COMMAND='PS1_COMMAND_ERROR=$?; _PS1_prompt'

# vim: ft=sh
