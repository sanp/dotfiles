#!/bin/bash

############################################################################
# This script installs the dotfiles.  First, installs all dependent packages,
# next, creates symlinks in home folder, finally fetches vim packages.
############################################################################

# Execute script as root user
echo "Installation will now begin."

cd ~

# Install packages needed for this dotfiles configuration -- if they're already
# installed, they will just spit out a warning saying that the package is
# already installed. Installing these packages may take a while.

##
# Homebrew
##
# Uninstall
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
# Install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

##
# Git
##
# Git -- ensure that git is up to date, and includes gitk, etc
brew install git
# Git completion and shell completion via homebrew
brew install bash-completion

##
# Python
##
# Macs come with python, but this will install the latest version
brew install python
# Pyenv: python version manager
brew install pyenv
# Virtualenv: environment manager
brew install pyenv-virtualenv

##
# Misc
##
# Exuberant ctags
brew install ctags-exuberant
# Pygments -- for nice colors in the terminal
sudo easy_install Pygments
# dos2unix
brew install dos2unix
# tmux
brew install tmux
# Tree - for viewing file directory structures
brew install tree
# Youtube downloader
brew install youtube-dl

echo "All packages now installed."

# Now install the dotfiles
cd ~/dotfiles
# The makesymlinks.sh script creates symlinks to the dotfiles in your home
# directory
./makesymlinks.sh
echo "Symlinks created."

# Fetch the vim submodules
cd ~/dotfiles
git submodule update --init --recursive
git submodule sync
echo "Vim submodules updated."

# Create the file which will store vim history, for vim MRU (most recently used)
# plugin
# To avoid getting an error the first time vim is opened, add a file to the vim 
# recent file history
echo '~/.profile' > ~/.vim_mru_files

# Copy desktop background images to home folder
cp -r ~/dotfiles/desktop_backgrounds $HOME

echo "Done! Restart your terminal and vim."
