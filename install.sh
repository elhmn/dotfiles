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

#install fuse
if ! command_exist fusermout; then
	echo "Installing fuse..."
	install_fuse
	echo "fuse installed!"
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

#install node
if ! command_exist node; then
	echo "Installing node..."
	install_node
	echo "node installed!"
fi

#install npm
if ! command_exist npm; then
	echo "Installing npm..."
	install_npm
	echo "NPM installed!"
fi

#install curl
if ! command_exist curl; then
	echo "Installing curl."
	install_curl
	echo "curl installed!"
fi

#install rust toolchain
if ! command_exist cargo; then
	echo "Installing the rust toolchain."
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
	echo "rust toolchain installed!"
fi


#install zsh
if [[ ! -d ~/.zshrc ]]; then
	echo "Installing zsh."
	install_zsh
	echo "zsh installed!"
fi

#install oh-my-zsh
if [[ ! -d ~/.oh-my-zsh ]]; then
	echo "Installing oh-my-zsh..."
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	echo "oh-my-zsh installed!"
fi

#setup new zsh theme
if [[ ! -d ~/.zshrc ]]; then
	echo "Setting up new zsh theme"
	#set a new theme
	sed  -i -s 's/\(ZSH_THEME\)="\(.*\)"/\1="fino"/g' ~/.zshrc
	echo "new zsh theme set!"
fi

#install gvm (go package manager)
if ! command_exist gvm; then
	echo "Installing gvm."
	install_gvm
	echo "gvm installed!"
fi

#setup vim config
if [[ ! -d ~/vimConfig ]]; then
	echo "Installing vim..."
	set +e
	git clone https://github.com/elhmn/vimConfig.git ~/vimConfig
	ln -sv ~/vimConfig/.vimrc ~/.vimrc
	ln -sv ~/vimConfig/.vimrc ~/.nvimrc
	ln -sv ~/vimConfig/.vim ~/.vim
	ln -sv ~/vimConfig/.vimsrcs ~/.vimsrcs
	#install plug
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	#setup nvim config
	if command_exist nvim; then
		mkdir -p  ~/.config/nvim
		ln -sv ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
		ln -sv ~/vimConfig/.vim/coc-settings.json ~/.config/nvim/coc-settings.json
		nvim --headless +PlugInstall +qall
		nvim --headless +CocInstall +qall
		echo "alias vim=nvim" >> ~/.zshrc
    fi

    #install coc extensions
	mkdir -p ~/.config/coc/extensions
	cd ~/.config/coc/extensions
	if [ ! -f package.json ]
	then
	  echo '{"dependencies":{}}'> package.json
	fi

	grep -e "'coc-.*'" -o ~/vimConfig/.vimrc | sed "s/[' ]//g;s/,/\n/g" | xargs -I{} npm install --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod {}; exit 0

	#setup copilot
	echo "setting up copilot..."
	git clone https://github.com/github/copilot.vim.git \
	~/.vim/pack/github/start/copilot.vim
	echo "copilot setup!"

	#update coc extensions
	nvim +CocUpdateSync +qall

	#fix neovim local utf8 not supported
	echo "export LC_ALL=en_US.UTF-8" >> ~/.zshrc
	echo "export LANG=en_US.UTF-8" >> ~/.zshrc

	#install language server
	sudo npm i -g bash-language-server
	set -e
	echo "Vim installed!"
fi


#setup gitconfig
echo "Setting up git configuration"
if [[ ! -f ~/.gitignore_global ]]; then
	ln -sv ~/dotfiles/git/.gitignore_global ~
	echo "git configuration set up!"
fi

if [[ ! -f ~/.gitconfig ]] || [[ ! $(grep "hide-status = 1" ~/.gitconfig) ]]; then
	ln -sv ~/dotfiles/git/.gitconfig ~
	echo "git configuration set up!"
fi
echo "git configuration set up!"

#install ckp
if [[ ! -d ~/.ckp ]]; then
	echo "Installing ckp..."
	curl https://raw.githubusercontent.com/elhmn/ckp/master/install.sh | bash
	cp ./bin/ckp /usr/local/bin
	rm -rf ./bin/ckp
	echo "ckp installed!"
fi
# 	echo "Initialising ckp..."
# 	ckp init https://github.com/elhmn/store
# 	echo "ckp initialized!"
