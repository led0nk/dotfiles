#!/usr/bin/bash

# set path variables
export REPO_PATH=/var/home/$USER/git/repo
export DOT_PATH=$REPO_PATH/dotfiles
export GITHUB=https://github.com/led0nk

# set some colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# check the existing symlinks
check_symlink() {
	tested_symlink="$1"

	if [ -L "$tested_symlink" ]; then
		if [ ! -e "$tested_symlink" ]; then
			echo "${RED}error${NC}: symlink for $tested_symlink is broken"
		else
			echo "${GREEN}checked ${NC}$tested_symlink\n"
		fi
	else
		echo "${RED}error${NC}: no symlink for $tested_symlink existing"
	fi
}

# create symlink & test or abort if test fails
symlink() {
	linkto=$1
	linkfrom=$2

	echo "creating symlink for $linkfrom:\n"
	ln -s "$linkto" "$linkfrom" && check_symlink "$linkfrom" || abort_func "$linkfrom"
}

# function for cloning git repo
install_git_repo() {
	repo=$1
	target=$2

	echo "cloning $repo\ninto $target\n"
	git clone "$GITHUB/$repo" "$target" || abort_func "$repo"
	echo "\ncloning of $repo done\n"
}

# function for exiting after error
abort_func() {
	errorfunction=$1
	echo "${RED}Error:${NC} exiting $errorfunction"
	exit 1
}

# create directories
mkdir -p "$HOME"/.config/{swappy,sway,waybar,rofi}
mkdir -p "$HOME"/Pictures/Wallpaper/

# clone GitHub repositories
install_git_repo dotfiles.git "$DOT_PATH"
install_git_repo images.git "$REPO_PATH"/images

# create symlinks for dotfiles
symlink "$DOT_PATH"/zsh/.zshrc "$HOME"/.zshrc
symlink "$DOT_PATH"/zsh/.zshenv "$HOME"/.zshenv
symlink "$DOT_PATH"/zsh/.p10k.zsh "$HOME"/.p10k.zsh
symlink "$DOT_PATH"/gitconfig/.gitconfig "$HOME"/.gitconfig
symlink "$DOT_PATH"/.config/sway/config "$HOME"/.config/sway/config
symlink "$DOT_PATH"/.config/waybar/config.jsonc "$HOME"/.zshrc
symlink "$DOT_PATH"/.config/waybar/style.css "$HOME"/.config/waybar/style.css
symlink "$DOT_PATH"/.config/nvim "$HOME"/.config/nvim
symlink "$DOT_PATH"/.config/swappy/config "$HOME"/.config/swappy/config

# copy themefiles and background
cp -r "$DOT_PATH"/.config/themes "$HOME"/.config/rofi/ || abort_func "copying rofi themes"
cp -r "$DOT_PATH"/background.png "$HOME"/Pictures/Wallpaper/background.png || abort_func "copying wallpaper"

# link golang variable
echo export PATH="$PATH":/usr/lib/golang/bin >>"$HOME"/.profile

# install zplug + extensions + change shell to zsh
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
chsh -s /usr/bin/zsh
zsh
zplug install

# generate ssh-key-with github alias-mail
ssh-keygen -t ed25519 -C "10290002+led0nk@users.noreply.github.com"

while getopts 'ynh' OPTION; do
	case "$OPTION" in
	y)
		sudo cp -r "$DOT_PATH"/etc/systemd/system/dotfile.service /etc/systemd/system/dotfile.service
		sudo chmod +x /etc/systemd/system/dotfile.service
		;;
	h)
		echo "install-dotfiles.sh [-y] [-h help]"
		echo "[-y]  -   includes systemd-service for automatic dotfiles-update at startup"
		echo "[-n]  -   excludes systemd-service for automatic dotfiles-update at startup"
		;;
	?)
		echo "install-dotfiles.sh [-y] [-n] [-h help]"
		exit 1
		;;
	esac
done
shift "$(($OPTIND - 1))"
