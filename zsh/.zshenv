if [[ "$(uname)" == "Darwin" ]]; then
  _bw_sock="$HOME/Library/Containers/com.bitwarden.desktop/Data/.bitwarden-ssh-agent.sock"
  if [[ -S "$_bw_sock" ]]; then
    export SSH_AUTH_SOCK="$_bw_sock"
  else
    _sock="$(launchctl getenv SSH_AUTH_SOCK 2>/dev/null)"
    [[ -z "$_sock" ]] && _sock="$(find /private/tmp -name Listeners -path '*/com.apple.launchd.*' 2>/dev/null | head -1)"
    export SSH_AUTH_SOCK="$_sock"
    unset _sock
  fi
  unset _bw_sock
else
  _bw_sock="$HOME/.bitwarden-ssh-agent.sock"
  if [[ -S "$_bw_sock" ]]; then
    export SSH_AUTH_SOCK="$_bw_sock"
  fi
  unset _bw_sock
fi
export PATH=$PATH:/usr/lib/golang/bin
# Not added by Fedora's zsh startup files; claude and other per-user tools land here.
export PATH=$HOME/.local/bin:$PATH
export CGO_ENABLED=0 