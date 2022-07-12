#!/bin/bash

set -ex

#import utils
#this will work only if curl installed
. ./lib.sh &>/dev/null || . <(curl -s https://raw.githubusercontent.com/elhmn/dotfiles/main/lib.sh)

if [[ ! -d ~/dotfiles ]]; then
	echo "Cloning dotfiles repository..."
	git clone https://github.com/elhmn/dotfiles.git ~/dotfiles
	echo "Dofiles repository installed!"
fi

#install vim
if ! command_exist vim; then
	echo "Installing vim..."
	install_vim
	echo "Vim installed!"
fi

#install nvim
if ! command_exist nvim; then
	echo "Installing nvim..."
	install_nvim
	echo "Nvim installed!"
fi

#install npm
# if ! command_exist npm; then
# 	echo "Installing npm..."
# 	install_npm
# 	echo "NPM installed!"
# fi

#install node
if ! command_exist node; then
	echo "Installing node..."
	install_node
	echo "node installed!"
fi

#install curl
if ! command_exist curl; then
	echo "Installing curl."
	install_curl
	echo "curl installed!"
fi

#install oh-my-zsh
if [[ ! -d ~/.oh-my-zsh ]]; then
	echo "Installing oh-my-zsh..."
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	echo "oh-my-zsh installed!"
fi

#setup vim config
if [[ ! -d ~/vimConfig ]]; then
	echo "Installing vim..."
	git clone https://github.com/elhmn/vimConfig.git ~/vimConfig
	ln -sv ~/vimConfig/.vimrc ~/.vimrc
	ln -sv ~/vimConfig/.vimrc ~/.nvimrc
	ln -sv ~/vimConfig/.vim ~/.vim
	ln -sv ~/vimConfig/.vimsrcs ~/.vimsrcs
	set +e
	mkdir -p  ~/.config/nvim
	ln -sv ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
	ln -sv ~/vimConfig/.vim/coc-settings.json ~/.config/nvim/coc-settings.json
	sudo vim -es -u ~/.vimrc +PlugInstall +qa
	sudo nvim --headless +PlugInstall +qall
	set -e
	#install language server
	sudo npm i -g bash-language-server
	echo "Vim installed!"
fi

#setup gitconfig
echo "Setting up git configuration"
# if [[ ! -f ~/.gitconfig ]]; then
# 	ln -sv ~/dotfiles/git/.gitconfig ~
# fi
if [[ ! -f ~/.gitignore_global ]]; then
	ln -sv ~/dotfiles/git/.gitignore_global ~
	echo "git configuration set up!"
fi
echo "git configuration set up!"

#install ckp
# if [[ ! -d ~/.ckp ]]; then
# 	echo "Installing ckp..."
# 	curl https://raw.githubusercontent.com/elhmn/ckp/master/install.sh | bash
# 	cp ./bin/ckp /usr/local/bin
# 	rm -rf ./bin/ckp
# 	echo "ckp installed!"
# 	echo "Initialising ckp..."
# 	ckp init https://github.com/elhmn/store
# 	echo "ckp initialized!"
# fi
