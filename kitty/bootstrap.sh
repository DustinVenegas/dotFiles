#!/bin/sh

symlink_if_missing()
{
    SOURCE=$1
    DEST=$2

    if [ ! -f "$DEST" ]; then
        ln -s "$SOURCE" "$DEST"
    fi
}

install_macos_homebrew_deps()
{
    command -v brew > /dev/null || echo 'Expected brew command, but not found. Is Homebrew for MacOS installed?' >&2

    if [ ! "$(brew bundle check)" ]; then
        brew bundle
    fi
}

# TODO: Support XDG_CONFIG_HOME
SCRIPT_DIR="$(cd "$(dirname "${0}")"; pwd)"

# Symlink configurations, if they don't already exist
symlink_if_missing "$SCRIPT_DIR/kitty.conf" "$HOME/.config/kitty/kitty.conf"

# Install software
install_macos_homebrew_deps
