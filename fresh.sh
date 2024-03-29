#!/bin/sh

echo "Kickstarting this baby"

# Utils

isOhMyZshExists() {
	[ -d ~/.oh-my-zsh ]
}

installOhMyZsh() {
	/bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
}

installHomebrew() {
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>$HOME/.zprofile
	eval "$(/opt/homebrew/bin/brew shellenv)"
}

isCommandExists() {
	command -v "$1" &
	>/dev/null
}

checkIfFileExists() {
	[ -f "$1" ]
}

installAntigen() {
	curl -L git.io/antigen >antigen.zsh
}

installTimer() {
	brew install caarlos0/tap/timer
}

installTerminalNotifier() {
	brew install terminal-notifier
}

# Setup

if isOhMyZshExists; then
	echo "oh-my-zsh is installed"
else
	installOhMyZsh
fi

if isCommandExists brew; then
	echo "homebrew is installed"
else
	installHomebrew
fi

if checkIfFileExists "./antigen.zsh"; then
	echo "antigen is installed"
else
	installAntigen
fi

unlink ~/.ideavimrc
ln -sf ~/dotfiles/.ideavimrc ~/.ideavimrc
unlink ~/.tmux.conf
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
unlink ~/.config/yabai
ln -sf ~/dotfiles/yabai ~/.config/yabai
unlink ~/.config/skhd
ln -sf ~/dotfiles/skhd ~/.config/skhd
unlink ~/.config/tmux
ln -sf ~/dotfiles/tmux ~/.config/tmux
unlink ~/.config/alacritty
ln -sf ~/dotfiles/alacritty ~/.config/alacritty

# Kitty
unlink ~/.config/kitty
rm -rf ~/.config/kitty
mkdir ~/.config/kitty
ln -sf ~/dotfiles/kitty.conf ~/.config/kitty/kitty.conf

if isCommandExists timer; then
	echo "timer is installed"
else
	installTimer
fi

if isCommandExists terminal-notifier; then
	echo "terminal-notifier is installed"
else
	installTerminalNotifier
fi

echo "Finished kickstarting"
