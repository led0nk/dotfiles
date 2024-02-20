#!/usr/bin/bash

# set Path variables
export REPO_PATH=/var/home/$USER/git/repo 
export DOT_PATH=$REPOPATH/dotfiles

#create directories
mkdir -p $HOME/.config/{sway, waybar, rofi}
mkdir -p $HOME/Pictures/Wallpaper/

#clone GitHub repositories
git clone https://github.com/led0nk/dotfiles.git $DOT_PATH
git clone https://github.com/led0nk/images.git $REPO_PATH/images
git clone https://github.com/led0nk/guestbook.git $REPO_PATH/guestbook

#create symlinks for dotfiles

ln -s $DOT_PATH/zsh/.zshrc $HOME/.zshrc
ln -s $DOT_PATH/zsh/.zshenv $HOME/.zshenv
ln -s $DOT_PATH/zsh/.p10k.zsh $HOME/.p10k.zsh
ln -s $DOT_PATH/gitconfig/.gitconfig $HOME/.gitconfig
ln -s $DOT_PATH/.config/sway/config $HOME/.config/sway/config
ln -s $DOT_PATH/.config/waybar/config.jsonc $HOME/.zshrc
ln -s $DOT_PATH/.config/waybar/style.css $HOME/.config/waybar/style.css

#copy themefiles and background
cp -r $DOT_PATH/.config/themes $HOME/.config/rofi/
cp -r $DOT_PATH/background.png $HOME/Pictures/Wallpaper/background.png

#link golang variable
echo export PATH=$PATH:/usr/lib/golang/bin > $HOME/.profile

#install zplug + extensions + change shell to zsh
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
chsh -s /usr/bin/zsh
zsh
zplug install

#generate ssh-key-with github alias-mail
ssh-keygen -t ed25519 -C "10290002+led0nk@users.noreply.github.com"
