#!/bin/bash

############################################################################
# This script installs the dotfiles.  First, install all dependent packages,
# next, create symlinks in home folder, then fetch vim packages.
############################################################################

# Execute script as root user
sudo echo "Installation will now begin."

cd ~

# Install packages needed for this dotfiles configuration -- if they're already
# installed, they will just spit out a warning saying that the package is
# already installed. Installing these packages may take a while.

# Homebrew
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
# Python - Macs come with python already, but this will install the latest 
# (2.x) version
brew install -U python
# Exuberant ctags
brew install ctags-exuberant
# Pygments -- for nice colors in the terminal
easy_install Pygments
# dos2unix
brew install dos2unix

echo "All packages now installed."

# Now install the dotfiles
cd ~/dotfiles
# The makesymlinks.sh script creates symlinks to the dotfiles in your home
# directory
chmod +x makesymlinks.sh
./makesymlinks.sh
echo "Symlinks created."

# Fetch the vim submodules
cd ~/dotfiles
git submodule init
git submodule update
echo "Vim submodules updated."

# For some reason, the increment plugin for vim uses dos line endings, even if
# downloaded to a Mac.  Use dos2unix to convert line endings to unix.
cd ~/dotfiles/vim/bundle/increment/plugin
dos2unix increment.vim

echo "Done! Restart your terminal and vim."
