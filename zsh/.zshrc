# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zsh plugins
ZPLUG_HOME=${HOME}/.zplug
source $ZPLUG_HOME/init.zsh
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

## ALIASES
# general
alias open=xdg-open
alias ls="eza -la"
alias ll="eza -abghHlS"
alias vim="nvim"
alias mkdir="mkdir -p"

# fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZT_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

alias ff='fzf -m --preview "bat --style=numbers --color=always {}"'
alias inv='nvim $(fzf -m --preview "bat --style=numbers --color=always {}")'
alias fa='aerospace list-windows --all | fzf --height=40% --bind "enter:execute(bash -c \"aerospace focus --window-id {1}\")+abort"'
alias fk='export KUBECONFIG=$(find $HOME/.kubeconfig -type f -name "*.yaml" | fzf --height=40% --prompt="Select kubeconfig: " --preview "bat --color=always {}") && echo "Switched KUBECONFIG to $KUBECONFIG"'
alias fn='kubectl config set-context --current --namespace=$(kubectl get namespaces --no-headers -o custom-columns=":metadata.name" | fzf --height=40% --prompt="Select namespace: ") && echo "Switched namespace to $(kubectl config view --minify --output "jsonpath={..namespace}")"'

# applications
alias eo=emacsclient -c -n $@
alias en=emacsclient -n $@
alias firefox="flatpak run org.mozilla.firefox"
alias signal="flatpak run org.signal.Signal"

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
source <(kubectl completion zsh)
source <(flux completion zsh)


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


#zplug "plugins/docker-compose", from:oh-my-zsh


export KUBECONFIG=$HOME/.kubeconfig/homelab.yaml
export KUBE_EDITOR="nvim"
export GOPATH=/home/$USER/.go
export COLORTERM=truecolor
export GO111MODULE=on
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/opt/homebrew/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:$HOME/.emacs.d/bin
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# FZF mappings and options
[ -f $HOME/.fzf/key-bindings.zsh ] && source $HOME/.fzf/key-bindings.zsh
[ -f $HOME/.fzf/completion.zsh ] && source $HOME/.fzf/completion.zsh

eval "$(fzf --zsh)"

# To customize prompt, run `p10k configure` or edit ~/git/repo/dotfiles/zsh/.p10k.zsh.
[[ ! -f ~/git/repo/dotfiles/zsh/.p10k.zsh ]] || source ~/git/repo/dotfiles/zsh/.p10k.zsh
