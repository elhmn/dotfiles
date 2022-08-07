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

#install oh-my-zsh
if [[ ! -d ~/.oh-my-zsh ]]; then
	echo "Installing oh-my-zsh..."
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
	#set the `essembeh` as theme
	sed  -i -s 's/\(ZSH_THEME\)="\(.*\)"/\1="essembeh"/g' ~/.zshrc
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

	#setup nvim config
	if command_exist nvim; then
		set +e
		mkdir -p  ~/.config/nvim
		ln -sv ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
		ln -sv ~/vimConfig/.vim/coc-settings.json ~/.config/nvim/coc-settings.json
		nvim --headless +PlugInstall +qall
		nvim --headless +CocInstall +qall
		echo "alias vim=nvim" >> ~/.zshrc
		set -e
    fi

    #install coc extensions
	mkdir -p ~/.config/coc/extensions
	cd ~/.config/coc/extensions
	if [ ! -f package.json ]
	then
  	  echo '{"dependencies":{}}'> package.json
	fi

	grep -e "'coc-.*'" -o ~/vimConfig/.vimrc | sed "s/[' ]//g;s/,/\n/g" | xargs -I{} npm install --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod {}; exit 0


	#update coc extensions
	nvim +CocUpdateSync +qall

	#install language server
	sudo npm i -g bash-language-server
	echo "Vim installed!"
fi

#setup gitconfig
echo "Setting up git configuration"
if [[ ! -f ~/.gitignore_global ]]; then
	ln -sv ~/dotfiles/git/.gitignore_global ~
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
