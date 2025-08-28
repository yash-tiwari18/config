# Bridge Windows SSH agent into WSL
export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
if [ ! -S $SSH_AUTH_SOCK ]; then
  mkdir -p ~/.ssh
  rm -f $SSH_AUTH_SOCK
  # Start socat bridge in background
  (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &)
fi
