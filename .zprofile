if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
if [[ -f "${XDG_RUNTIME_DIR}/ssh-agent.sock" ]] then
  export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.sock"
fi
