#!/bin/bash

set -e

#import utils
. ./lib.sh

if [[ ! -d ~/dotfiles ]]; then
	echo "Cloning dotfiles repository..."
	git clone https://github.com/elhmn/dotfiles.git ~/dotfiles
	echo "Dofiles repository installed!"
fi

#setup gitconfig
if [[ ! -f ~/.gitconfig ]]; then
	echo "Setting up git configuration"
	ln -sv ~/dotfiles/git/.gitconfig ~
	ln -sv ~/dotfiles/git/.gitignore_global ~
	echo "git configuration set up!"
fi

#install vim
if ! command_exist vim; then
	echo "Installing vim..."
	install_vim
	echo "Vim installed!"
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
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	echo "oh-my-zsh installed!"
fi

#install ckp
if [[ ! -d ~/.ckp ]]; then
	echo "Installing ckp..."
	curl https://raw.githubusercontent.com/elhmn/ckp/master/install.sh | bash 
	sudo cp ./bin/ckp /usr/local/bin
	echo "ckp installed!"
	echo "Initialising ckp..."
	ckp init https://github.com/elhmn/store
	echo "ckp initialized!"

fi
