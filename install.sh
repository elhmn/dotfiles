#!/bin/bash

set -e

#import utils
#this will work only if curl installed
. ./lib.sh

if [[ ! -d ~/dotfiles ]]; then
	echo "Cloning dotfiles repository..."
	git clone https://github.com/elhmn/dotfiles.git ~/dotfiles
	echo "Dofiles repository installed!"
fi

#setup gitconfig
echo "Setting up git configuration"
if [[ ! -f ~/.gitconfig ]]; then
	ln -sv ~/dotfiles/git/.gitconfig ~
fi
if [[ ! -f ~/.gitignore_global ]]; then
	ln -sv ~/dotfiles/git/.gitignore_global ~
	echo "git configuration set up!"
fi
echo "git configuration set up!"

#install vim
if ! command_exist vim; then
	echo "Installing vim..."
	install_vim
	echo "Vim installed!"
fi

#install npm
if ! command_exist npm; then
	echo "Installing npm..."
	install_npm
	echo "NPM installed!"
fi

#install npm
if ! command_exist node; then
	echo "Installing node..."
	install_npm
	echo "node installed!"
fi

#setup vim config
if [[ ! -d ~/vimConfig ]]; then
	echo "Installing vim..."
	cp -R ./vimConfig ~/vimConfig
	ln -sv ~/vimConfig/.vimrc ~/.vimrc
	ln -sv ~/vimConfig/.vim ~/.vim
	ln -sv ~/vimConfig/.vimsrcs ~/.vimsrcs
	vim -es -u ~/.vimrc +PlugInstall +qa
	#install language server
	npm i -g bash-language-server
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
	rm -rf ./bin/ckp
	echo "ckp installed!"
	echo "Initialising ckp..."
	ckp init https://github.com/elhmn/store
	echo "ckp initialized!"
fi
