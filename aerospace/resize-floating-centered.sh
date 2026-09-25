#!/usr/bin/env bash
# Borrowed from https://github.com/franckrasolo/dotfiles.nix/blob/d87978c18e42313f0c43026f5488646126f48e89/darwin/aerospace/resize-floating-centered.sh

set -o errexit
set -o nounset
set -o pipefail

# resize/reposition the focused window
osascript -e "
tell application \"System Events\"
  set _app to name of first application process whose frontmost is true
  tell process _app
    set _window to front window
    set {x, y, width, height} to _window's position & _window's size
    set position of _window to {x - ($1 / 2), y - ($2 / 2)}
    set size of _window to {width + $1, height + $2}
    activate
  end tell
end tell
" && aerospace flatten-workspace-tree
