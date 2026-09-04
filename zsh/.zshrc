# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# One file for every machine. Platform-specific bits are guarded below.
if [[ "$(uname)" == "Darwin" ]]; then
  IS_MAC=1
else
  IS_MAC=0
fi

# history
export HISTFILE=~/.zsh_history
export HISTSIZE=200000
export SAVEHIST=200000
setopt SHARE_HISTORY          # share history across all sessions in real-time
setopt HIST_IGNORE_ALL_DUPS   # remove older duplicate when new entry is added
setopt HIST_IGNORE_SPACE      # don't record commands starting with a space
setopt HIST_REDUCE_BLANKS     # remove unnecessary blanks
setopt HIST_VERIFY            # show substituted command before running it
setopt extended_glob

# zsh plugins
ZPLUG_HOME=${HOME}/.zplug
[ -f $ZPLUG_HOME/init.zsh ] && source $ZPLUG_HOME/init.zsh
#zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug romkatv/powerlevel10k, as:theme, depth:1
#zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/history", from:oh-my-zsh
zplug "plugins/docker", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "chrissicool/zsh-256color"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug load

bindkey -e
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
#bindkey '^h' backward-delete-char
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^R" history-incremental-pattern-search-backward
bindkey '^[[Z' autosuggest-accept
bindkey '^h' backward-char
bindkey '^l' forward-char
bindkey '^j' backward-word
bindkey '^k' forward-word
bindkey '^g' fzf_proj

## ALIASES
# general
alias ls="eza -la"
alias ll="eza -abghHlS"
alias vim="nvim"
alias mkdir="mkdir -p"
(( IS_MAC )) || alias open=xdg-open   # macOS has its own `open`

# fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZT_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_OPTS="--layout=reverse"
# alt-c: show what is in a directory before cd-ing into it
export FZF_ALT_C_OPTS="--preview 'eza -la --color=always {}'"

alias ff='fzf -m --preview "bat --style=numbers --color=always {}"'
alias inv='nvim $(fzf -m --preview "bat --style=numbers --color=always {}")'
alias fk='export KUBECONFIG=$(find $HOME/.kubeconfig -type f -name "*.yaml" | fzf --height=40% --prompt="Select kubeconfig: " --preview "bat --color=always {}") && echo "Switched KUBECONFIG to $KUBECONFIG"'
alias fn='kubectl config set-context --current --namespace=$(kubectl get namespaces --no-headers -o custom-columns=":metadata.name" | fzf --height=40% --prompt="Select namespace: ") && echo "Switched namespace to $(kubectl config view --minify --output "jsonpath={..namespace}")"'
# docker: pick image(s) with TAB, remove them
alias fdrmi='docker images --format "{{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedSince}}\t{{.Size}}" | column -t -s $'\''\t'\'' | fzf -m --height=40% --prompt="Remove image: " --header="TAB to mark, ENTER to remove" | awk '\''{print $3}'\'' | xargs -r docker rmi'
# same for podman (Linux/ThinkPad)
alias fprmi='podman images --format "{{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedSince}}\t{{.Size}}" | column -t -s $'\''\t'\'' | fzf -m --height=40% --prompt="Remove image: " --header="TAB to mark, ENTER to remove" | awk '\''{print $3}'\'' | xargs -r podman rmi'
(( IS_MAC )) && alias fa='aerospace list-windows --all | fzf --height=40% --bind "enter:execute(bash -c \"aerospace focus --window-id {1}\")+abort"'

# applications
if (( IS_MAC )); then
  alias eo="emacsclient -t"
  alias en="emacsclient -t -n"
else
  alias firefox="flatpak run org.mozilla.firefox"
  alias signal="flatpak run org.signal.Signal"
fi
# Start Claude with the Obsidian brain loaded. The SessionStart hook injects the
# operating rules and MAP.md only when the session starts inside the vault.
alias brain='cd ~/Nextcloud/Notes && claude'

# navigation
alias .1="cd .."
alias .2="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."

# git
alias gs="git status"
alias gp="git push"
alias ga="git add"
alias gaa="git add ."
alias gcm="git commit -m"
alias gf="git fetch"
alias gc="git checkout"
alias gd="git diff"

# kubectl
alias k="kubectl"
alias kubectl="kubectl --insecure-skip-tls-verify"

# completions, only for what is actually installed on this machine
for _c in kubectl flux talhelper talosctl flyctl; do
  (( $+commands[$_c] )) && source <($_c completion zsh)
done
unset _c

command -v mise >/dev/null && eval "$(mise activate zsh)"

if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh)"
  alias cd='z'
fi

####### functions

_fzf_proj_widget() {
  # declare up front: `local` inside the loop below re-declares an already-set
  # name each iteration, which makes zsh print "b=<value>" into the list
  local base="$HOME/git/repo" name gitpath root b
  # no -type d: for a worktree the .git is a file, and those are repos too
  name=$(
    find "$base" -maxdepth 2 -name .git -prune -print \
    | while read -r gitpath; do
        root=${gitpath%/.git}
        b=$(git -C "$root" branch --show-current 2>/dev/null)
        [[ -n $b ]] || b=$(git -C "$root" rev-parse --short HEAD 2>/dev/null)
        printf '%s\t%s\n' "${root:t}" "${b:--}"
      done | sort \
    | column -t -s $'\t' \
    | fzf --height=40% --prompt="Select project: " \
    | awk '{print $1}'
  )

  if [[ -n $name ]]; then
    printf -v LBUFFER 'cd %q' "$base/$name"
    zle accept-line
  fi
}

zle -N fzf_proj _fzf_proj_widget

# pick process(es) and signal them; default TERM, e.g. `fkill 9` for KILL
fkill() {
  local sig=${1:-15} pids
  pids=$(
    ps -ef | sed 1d \
    | fzf -m --height=40% --nth=8.. --prompt="Signal $sig to: " --header="TAB to mark" \
    | awk '{print $2}'
  )
  [[ -n $pids ]] && print -r -- "$pids" | xargs -r kill -"$sig"
}

fbr() {
  git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repository"; return 1; }
  local branch fmt
  # git --format does not expand \t, so build the format with a real tab
  fmt=$'%(refname:short)\t%(committerdate:relative)\t%(contents:subject)'
  branch=$(
    git branch -a --sort=-committerdate --format="$fmt" \
    | column -t -s $'\t' \
    | fzf --height=40% --nth=1 --prompt="Checkout branch: " --header="newest first" \
    | awk '{print $1}'
  )
  [[ -n $branch ]] && git checkout "${branch#origin/}"
}

_lazygit_widget() {
  lazygit
  zle reset-prompt
}
zle -N lazygit_widget _lazygit_widget
bindkey ' lg' lazygit_widget

function acp(){
  commitmsg=$1
  repository=$2
  branch=$3

  if [[ -z $commitmsg || -z $repository || -z $branch ]]; then
    echo "Usage: acp [commit message] [repository] [branch]"
    echo "       automatically adds all files to commit"
    return 1
  fi

  git add .
  git commit -m "$commitmsg"
  git push $repository $branch

}

# function for extraction of any compressed files
function extract {
 if [ $# -eq 0 ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz|.zlib|.cso|.zst>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 fi
    for n in "$@"; do
        if [ ! -f "$n" ]; then
            echo "'$n' - file doesn't exist"
            return 1
        fi

        case "${n%,}" in
          *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                       tar zxvf "$n"       ;;
          *.lzma)      unlzma ./"$n"      ;;
          *.bz2)       bunzip2 ./"$n"     ;;
          *.cbr|*.rar) unrar x -ad ./"$n" ;;
          *.gz)        gunzip ./"$n"      ;;
          *.cbz|*.epub|*.zip) unzip ./"$n"   ;;
          *.z)         uncompress ./"$n"  ;;
          *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar|*.vhd)
                       7z x ./"$n"        ;;
          *.xz)        unxz ./"$n"        ;;
          *.exe)       cabextract ./"$n"  ;;
          *.cpio)      cpio -id < ./"$n"  ;;
          *.cba|*.ace) unace x ./"$n"     ;;
          *.zpaq)      zpaq x ./"$n"      ;;
          *.arc)       arc e ./"$n"       ;;
          *.cso)       ciso 0 ./"$n" ./"$n.iso" && \
                            extract "$n.iso" && \rm -f "$n" ;;
          *.zlib)      zlib-flate -uncompress < ./"$n" > ./"$n.tmp" && \
                            mv ./"$n.tmp" ./"${n%.*zlib}" && rm -f "$n"   ;;
          *.dmg)
                      hdiutil mount ./"$n" -mountpoint "./$n.mounted" ;;
          *.tar.zst)  tar -I zstd -xvf ./"$n"  ;;
          *.zst)      zstd -d ./"$n"  ;;
          *)
                      echo "extract: '$n' - unknown archive method"
                      return 1
                      ;;
        esac
    done
}

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

####### environment

export COLORTERM=truecolor
export GO111MODULE=on
export KUBE_EDITOR="nvim"
export _ZO_DOCTOR=0

if (( IS_MAC )); then
  export GOPATH=$HOME/go
  export KUBECONFIG=$HOME/.kubeconfig/jupiter.yaml
  export PATH="/opt/homebrew/bin:$PATH"
  export PATH=$PATH:$HOME/.config/emacs/bin
else
  export GOPATH=$HOME/.go
  export KUBECONFIG=$HOME/.kubeconfig/homelab.yaml
  export TALOSCONFIG=$HOME/git/repo/hmlb/infra/clusterconfig/talosconfig
  export GTK_THEME=Adwaita-dark
fi

export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/bin

export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                  # loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# SSH_AUTH_SOCK and ~/.local/bin come from .zshenv
if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
elif command -v fzf >/dev/null; then
  eval "$(fzf --zsh)"
fi
