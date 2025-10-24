if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export MONO_GAC_PREFIX="/opt/homebrew/"
  export DOTNET_ROOT="/opt/homebrew/opt/dotnet/libexec/"
fi
if [ $OSTYPE = linux-gnu ]; then
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi
