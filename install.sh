#!/bin/bash

############################################################################
# This script installs the dotfiles.  First, installs all dependent packages,
# next, creates symlinks in home folder, finally fetches vim packages.
############################################################################

# Execute script as root user
sudo echo "Installation will now begin."

cd ~

# Install packages needed for this dotfiles configuration -- if they're already
# installed, they will just spit out a warning saying that the package is
# already installed. Installing these packages may take a while.

# Homebrew
ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
# Git -- ensure that git is up to date, and includes gitk, etc
brew install git
# Git completion and shell completion via homebrew
brew install bash-completion
# Python - Macs come with python already, but this will install the latest 
# (2.x) version
brew install -U python
# Exuberant ctags
brew install ctags-exuberant
# Pygments -- for nice colors in the terminal
easy_install Pygments
# dos2unix
brew install dos2unix
# tmux
brew install tmux
# Tree - for viewing file directory structures
brew install tree

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

# Create the file which will store vim history, for vim MRU (most recently used)
# plugin
cd ~
touch .vim_mru_files
# To avoid getting an error the first time vim is opened, add a file to the vim 
# recent file history
echo '~/.profile' >> ~/.vim_mru_files

echo "Done! Restart your terminal and vim."
