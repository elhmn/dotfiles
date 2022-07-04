function is_macos() {
	osname=$(uname)
	return $([[ "$osname" == "Darwin" ]]; echo $?)
}

function is_linux() {
	osname=$(uname)
	return $([[ "$osname" == "Linux" ]]; echo $?)
}

function command_exist() {
	command=$1
	return $(type $command &>/dev/null; echo $?)
}

function install_vim() {
	if is_macos; then
		brew uninstall ex-vi macvim
		sudo chown -R `whoami`:admin /usr/local/share/man/de/man1
		brew link vim
		brew install vim
	elif is_linux; then
		sudo apt update -y && sudo apt-get install vim -y
	fi
}

function install_nvim() {
	if is_macos; then
		brew uninstall neovim
		brew uninstall --ignore-dependencies luajit
		brew install --HEAD luajit
		brew install --HEAD neovim
	elif is_linux; then
		wget --quiet https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage --output-document nvim
		chmod u+x nvim
		sudo mv nvim /usr/local/bin/nvim
	fi
}



function install_curl() {
	if is_linux; then
		sudo apt update -y && sudo apt-get install curl -y
	fi
}

function install_npm() {
	if is_linux; then
		sudo apt update -y && sudo apt-get install npm -y
	fi
}

function install_node() {
	if is_linux; then
		sudo apt update -y && sudo apt-get install nodejs -y
	fi
}
