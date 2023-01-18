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

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
}

isCommandExists() {
  command -v "$1" &> /dev/null
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
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Finished kickstarting"
