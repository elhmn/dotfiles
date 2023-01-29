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
		#TODO
		echo "Is mac"
	elif is_linux; then
		sudo apt update -y && sudo apt-get install vim -y
	fi
}

function install_fuse() {
	if is_macos; then
		#TODO
		echo "Is mac"
	elif is_linux; then
		sudo apt install libfuse2 -y
	fi
}

function install_nvim() {
	if is_macos; then
		#TODO
		echo "Is mac"
	elif is_linux; then
		wget --quiet https://github.com/neovim/neovim/releases/download/v0.7.2/nvim.appimage --output-document nvim-bin
		chmod u+x nvim-bin
		sudo mv nvim-bin /usr/local/bin/nvim
	fi
}

#install gvm (go package manager)
function install_gvm() {
	if is_macos; then
		#TODO
		echo "Is mac"
	elif is_linux; then
		bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
	fi
}

#install zsh
function install_zsh() {
	if is_macos; then
		#TODO
		echo "Is mac"
	elif is_linux; then
		sudo apt install zsh -y
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
		sudo apt update -y
		curl -sL https://deb.nodesource.com/setup_16.x | sudo bash -
		sudo apt-get install -y nodejs
	fi
}
