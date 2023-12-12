#create directories
mkdir -p git/repo/{dotfiles,minecraft,images}


#clone git repositories
git clone git@github.com:led0nk/dotfiles.git ~/git/repo/dotfiles
git clone git@github.com:led0nk/minecraft.git ~/git/repo/minecraft
git clone git@github.com:led0nk/images.git ~/git/repo/images


#create systemlinks for dotfiles
ln -s ~/git/repo/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/git/repo/dotfiles/zsh/.p10k.zsh ~/.p10k.zsh
ln -s ~/git/repo/dotfiles/gitconfig/.gitconfig ~/.gitconfig
