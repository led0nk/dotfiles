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
# https://linux.die.net/man/1/zshzle
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^R" history-incremental-pattern-search-backward
bindkey '^[[Z' autosuggest-accept
alias eo=emacsclient -c -n $@
alias en=emacsclient -n $@
alias ls="eza -la"
alias ll="eza -abghHlS"
alias open=xdg-open
alias firefox="flatpak run org.mozilla.firefox"
alias signal="flatpak run org.signal.Signal"


## case-insensitive (uppercase from lowercase) completion
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
## case-insensitive (all) completion
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
## case-insensitive,partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


# alias monitor=xrandr --output HDMI2 --auto; sleep 2; xrandr --output eDP1 --off
# alias laptop=xrandr --output eDP1 --auto; sleep 2; xrandr --output HDMI2 --off

#zplug "plugins/docker-compose", from:oh-my-zsh

export GOPATH=/home/$USER/go
export PATH=$PATH:$GOPATH/bin
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
