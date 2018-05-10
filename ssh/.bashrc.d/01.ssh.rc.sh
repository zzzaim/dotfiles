# keeagent or ssh-agent
if [[ -n "$KEEAGENT_SSH_AUTH_SOCK" ]]; then
  export SSH_AUTH_SOCK=/tmp/ssh_auth_sock
  ~/bin/msysgit2unix-socket.py $KEEAGENT_SSH_AUTH_SOCK:$SSH_AUTH_SOCK &>/dev/null
elif ! pgrep -u "$USER" ssh-agent &>/dev/null; then
  ssh-agent > ~/.ssh-agent-bits
  if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-bits)" &>/dev/null
  fi
fi
