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
			printf "${RED}error${NC}: symlink for %s is broken\n" "$tested_symlink"
		else
			printf "${GREEN}checked ${NC}%s\n" "$tested_symlink"
		fi
	else
		printf "${RED}error${NC}: no symlink for %s existing\n" "$tested_symlink"
	fi
}

# create symlink & test or abort if test fails
symlink() {
	linkto=$1
	linkfrom=$2

	printf "creating symlink for %s:\n" "$linkfrom"
	ln -sfn "$linkto" "$linkfrom" && check_symlink "$linkfrom" || abort_func "$linkfrom"
}

# function for cloning git repo
install_git_repo() {
	repo=$1
	target=$2

	if [ -d "$target/.git" ]; then
		echo "$target already cloned, skipping"
		return
	fi

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
mkdir -p "$HOME"/.config/{swappy,sway,waybar,rofi,dunst,mako,swaync,swaylock,tmux,environment.d}
mkdir -p "$HOME"/Pictures/{Wallpaper,Screenshots}
mkdir -p "$HOME"/.ssh
chmod 700 "$HOME"/.ssh

# clone GitHub repositories
install_git_repo dotfiles.git "$DOT_PATH"
install_git_repo images.git "$REPO_PATH"/images

# create symlinks for dotfiles
symlink "$DOT_PATH"/zsh/.zshrc "$HOME"/.zshrc
symlink "$DOT_PATH"/zsh/.zshenv "$HOME"/.zshenv
symlink "$DOT_PATH"/zsh/.p10k.zsh "$HOME"/.p10k.zsh
symlink "$DOT_PATH"/gitconfig/.gitconfig "$HOME"/.gitconfig
symlink "$DOT_PATH"/gitconfig/.gitignore_global "$HOME"/.gitignore_global
symlink "$DOT_PATH"/gitconfig/allowed_signers "$HOME"/.ssh/allowed_signers
symlink "$DOT_PATH"/.config/sway/config "$HOME"/.config/sway/config
symlink "$DOT_PATH"/.config/sway/scripts "$HOME"/.config/sway/scripts
symlink "$DOT_PATH"/.config/waybar/config.jsonc "$HOME"/.config/waybar/config.jsonc
symlink "$DOT_PATH"/.config/waybar/style.css "$HOME"/.config/waybar/style.css
symlink "$DOT_PATH"/.config/waybar/scripts "$HOME"/.config/waybar/scripts
symlink "$DOT_PATH"/.config/nvim "$HOME"/.config/nvim
symlink "$DOT_PATH"/.config/swappy/config "$HOME"/.config/swappy/config
symlink "$DOT_PATH"/.config/dunst/dunstrc "$HOME"/.config/dunst/dunstrc
symlink "$DOT_PATH"/.config/dunst/normal.png "$HOME"/.config/dunst/normal.png
symlink "$DOT_PATH"/.config/dunst/critical.png "$HOME"/.config/dunst/critical.png
symlink "$DOT_PATH"/.config/mako/config "$HOME"/.config/mako/config
symlink "$DOT_PATH"/.config/mako/normal.png "$HOME"/.config/mako/normal.png
symlink "$DOT_PATH"/.config/mako/critical.png "$HOME"/.config/mako/critical.png
symlink "$DOT_PATH"/.config/swaync/config.json "$HOME"/.config/swaync/config.json
symlink "$DOT_PATH"/.config/swaync/style.css "$HOME"/.config/swaync/style.css
symlink "$DOT_PATH"/.config/swaylock/config "$HOME"/.config/swaylock/config
symlink "$DOT_PATH"/.config/tmux/tmux.conf "$HOME"/.config/tmux/tmux.conf
symlink "$DOT_PATH"/.config/rofi/config.rasi "$HOME"/.config/rofi/config.rasi
symlink "$DOT_PATH"/.config/environment.d/10-ssh-auth-sock.conf "$HOME"/.config/environment.d/10-ssh-auth-sock.conf
symlink "$DOT_PATH"/.config/environment.d/20-xdg-screenshots.conf "$HOME"/.config/environment.d/20-xdg-screenshots.conf

# copy themefiles and background
mkdir -p "$HOME"/.config/rofi/themes
cp -r "$DOT_PATH"/.config/rofi/themes/. "$HOME"/.config/rofi/themes/ || abort_func "copying rofi themes"
cp "$DOT_PATH"/background.png "$HOME"/Pictures/Wallpaper/background.png || abort_func "copying wallpaper"


# install zplug + extensions + change shell to zsh
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
chsh -s /usr/bin/zsh
zsh -ic "zplug install"

# generate ssh-key-with github alias-mail
if [ ! -f "$HOME"/.ssh/id_ed25519 ]; then
	ssh-keygen -t ed25519 -C "10290002+led0nk@users.noreply.github.com"
fi

