if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export MONO_GAC_PREFIX="/opt/homebrew/"
  export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec/"
fi
if [ -S "$XDG_RUNTIME_DIR/ssh-agent.sock" ]; then
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.sock"
fi
