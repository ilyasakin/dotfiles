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

	# zsh/zprofile (linked below) already sets up Homebrew's environment
	eval "$(/opt/homebrew/bin/brew shellenv)"
}

isCommandExists() {
	command -v "$1" >/dev/null 2>&1
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

# Symlink configs, scripts and git settings (safe to re-run)
sh ./link.sh

# Everything installed with Homebrew (regenerate with: brew bundle dump --force --file=Brewfile)
brew bundle --file=./Brewfile

# AeroSpace float-centering helper is compiled, not committed
if [ ! -x ./aerospace/center_float ] && isCommandExists swiftc; then
	swiftc -O ./aerospace/center_float.swift -o ./aerospace/center_float
fi

# Daily cache cleanup (launchd won't follow a symlinked plist, so copy it)
cp ./launchd/com.ilyasakin.daily-cleanup.plist ~/Library/LaunchAgents/
launchctl bootstrap "gui/$(id -u)" ~/Library/LaunchAgents/com.ilyasakin.daily-cleanup.plist 2>/dev/null || true

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
