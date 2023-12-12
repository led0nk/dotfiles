#! /usr/bin/bash


#set repository-path
export PATH=~/git/repo/


#create directories
mkdir -p git/repo/{dotfiles,minecraft,images}


#clone git repositories
git clone git@github.com:led0nk/dotfiles.git $PATH/dotfiles
git clone git@github.com:led0nk/minecraft.git $PATH/minecraft
git clone git@github.com:led0nk/images.git $PATH/repo/images


#create systemlinks for dotfiles
ln -s $PATH/dotfiles/zsh/.zshrc ~/.zshrc
ln -s $PATH/dotfiles/zsh/.p10k.zsh ~/.p10k.zsh
ln -s $PATH/dotfiles/gitconfig/.gitconfig ~/.gitconfig


#install zplug + extensions + change shell to zsh
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
chsh -s /usr/bin/zsh
zsh
zplug install