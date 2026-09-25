#!/bin/sh
# Symlink everything this repo manages into place. Safe to re-run:
# correct links are left alone, and anything else in the way is moved
# to ~/.dotfiles-backup/<timestamp>/ instead of being overwritten.
#
#   ./link.sh            link everything
#   ./link.sh --dry-run  only print what would change

DOT="$(cd "$(dirname "$0")" && pwd)"
DRY=0; [ "${1:-}" = "--dry-run" ] && DRY=1
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
changed=0

link() { # link <path in repo> <target path>
	src="$DOT/$1"; dst="$2"
	if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then return; fi
	changed=$((changed + 1))
	if [ $DRY = 1 ]; then echo "would link $dst -> $src"; return; fi
	mkdir -p "$(dirname "$dst")"
	if [ -e "$dst" ] || [ -L "$dst" ]; then
		mkdir -p "$BACKUP"; mv "$dst" "$BACKUP/"
		echo "backed up $dst to $BACKUP/"
	fi
	ln -s "$src" "$dst" && echo "linked $dst -> $src"
}

# shell
link zsh/zshrc    "$HOME/.zshrc"
link zsh/zprofile "$HOME/.zprofile"
link zsh/zshenv   "$HOME/.zshenv"

# terminals, multiplexer, editors
link alacritty    "$HOME/.config/alacritty"
link kitty.conf   "$HOME/.config/kitty/kitty.conf"
link tmux         "$HOME/.config/tmux"
link .ideavimrc   "$HOME/.ideavimrc"

# window management
link aerospace    "$HOME/.config/aerospace"
link yabai        "$HOME/.config/yabai"
link skhd         "$HOME/.config/skhd"

# git: shared settings are included from ~/.gitconfig, which stays machine-local
# (identity, and whatever `git config --global` writes)
link git/ignore   "$HOME/.config/git/ignore"
if ! git config --file "$HOME/.gitconfig" --get-all include.path 2>/dev/null | grep -qxE "($DOT/git/gitconfig|~/dotfiles/git/gitconfig)"; then
	changed=$((changed + 1))
	if [ $DRY = 1 ]; then echo "would add [include] of $DOT/git/gitconfig to ~/.gitconfig"
	else
		git config --file "$HOME/.gitconfig" --add include.path "$DOT/git/gitconfig"
		echo "added include of $DOT/git/gitconfig to ~/.gitconfig"
		git config --file "$HOME/.gitconfig" user.email >/dev/null || echo "  set your identity: git config --global user.name/user.email"
	fi
fi

# scripts
for s in c tms dev finer-chat daily-cleanup; do link "scripts/$s" "$HOME/.local/bin/$s"; done
link scripts/finer-chat "$HOME/.local/bin/qwen"

[ $DRY = 1 ] && echo "$changed change(s) needed" || echo "done: $changed change(s)"
