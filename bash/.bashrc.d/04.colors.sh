# color shortcuts
declare -A AT
declare -A FG
declare -A BG

# Attributes
AT[reset]=0
AT[bold]=1
AT[dim]=2
AT[underline]=4
AT[blink]=5
AT[reverse]=7
AT[hidden]=8

# Foreground colors
FG[default]=39
FG[black]=30
FG[red]=31
FG[green]=32
FG[yellow]=33
FG[blue]=34
FG[magenta]=35
FG[cyan]=36
FG[lightgray]=37
FG[darkgray]=90
FG[lightred]=91
FG[lightgreen]=92
FG[lightyellow]=93
FG[lightblue]=94
FG[lightmagenta]=95
FG[lightcyan]=96
FG[white]=97

# Background colors
BG[default]=49
BG[black]=40
BG[red]=41
BG[green]=42
BG[yellow]=43
BG[blue]=44
BG[magenta]=45
BG[cyan]=46
BG[lightgray]=47
BG[darkgray]=100
BG[lightred]=101
BG[lightgreen]=102
BG[lightyellow]=103
BG[lightblue]=104
BG[lightmagenta]=105
BG[lightcyan]=106
BG[white]=107

end() {
  local s= e=

  if [[ "$1" == "-e" ]]; then
    s='\['
    e='\]'
  fi

  echo -ne "${s}\033[0m${e}"
}

# function color [-e] FG, [BG|AT, [BG|AT]]
#
# If option -e is given, the escape codes are espaced using \[...\],
# for use in command prompt PS1.
#
# First color is foreground color, second and third can be either
# background color or text attribute.
#
# Example:
#   color yellow
#   color yellow darkgray bold
#   color white bold
#   color red bold blue
#
#   echo $(c red underline)WARNING MESSAGE$(end)
color() {
  local p= a=() s= e=

  for p in $@; do
    { [[ "$p" == "-e" ]] && { s='\['; e='\]'; }; } || \
    { [[ -n "${AT[$p]}" ]] && a[0]=${AT[$p]}; } || \
    { [[ -n "${FG[$p]}" && -z "${a[1]}" ]] && a[1]=${FG[$p]}; } || \
    { [[ -n "${BG[$p]}" ]] && a[2]=${BG[$p]}; }
  done

  a[0]=${a[0]:-${AT[reset]}}
  a[1]=${a[1]:-${FG[default]}}
  a[2]=${a[2]:-${BG[default]}}

  a="${a[@]}"     ; [[ -n "$DEBUG" ]] && echo "$a" >&2
  a="${a// /;}"   ; [[ -n "$DEBUG" ]] && echo "$a" >&2
  echo -ne "${s}\033[${a}m${e}"
}

# Color variables and shorcuts
#
# Color names are title-cased to avoid any conflicts.
#
# Example:
#   Yellow
#   Yellow bold darkgray
#   Blue red underline
#   Darkgray magenta
#
#   echo $(Red)Warning:$(r)
#   echo $(Blue underline)link to something$(end)
for n in "${!FG[@]}"; do
  a="$(echo ${n:0:1} | tr [:lower:] [:upper:])${n:1}"
  alias $a="color $n"
  declare -x $a="$(color $n)"
  declare -x e$a="\[$(color $n)\]"
done

alias c=color
alias eend='end -e'
declare -x end="$(end)"
declare -x eend="$(end -e)"

unset n a

# vim: ft=sh
