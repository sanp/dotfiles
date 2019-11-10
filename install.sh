#!/bin/bash

################################################################################
# This script installs the dotfiles.  First, it installs all dependent packages,
# next, it creates symlinks in home folder, and finally it fetches vim packages.
################################################################################

set -e

# Execute script as root user
echo "Installation will now begin."

# It's not possible to completely remove the Dock from macs, but you can hide it
# and then lengthen the amount of time it takes to display the dock after hover:
defaults write com.apple.Dock autohide-delay -float 5 && killall Dock

# Install packages needed for this dotfiles configuration -- if they're already
# installed, they will just spit out a warning saying that the package is
# already installed. Installing these packages may take a while.

##
# Homebrew
##
# Uninstall
if [ -d "/usr/local/Homebrew" ]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
fi
# Install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

##
# Bash
##
# Install latest bash
brew install bash
# Add the new bash shell to the list of allowed shells
sudo bash -c "echo /usr/local/bin/bash >> /private/etc/shells"
# Change the shell for the user
chsh -s /usr/local/bin/bash 

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
# Scala
##
brew install scala
brew install sbt

##
# Tmux
##
brew install tmux
# reattach-to-user-namespace necessary for doing vim copy/pasting in tmux window
brew install reattach-to-user-namespace

##
# R
##
brew install r

##
# Misc
##
# Exuberant ctags
brew install ctags-exuberant
# Pygments -- for nice colors in the terminal
sudo easy_install Pygments
# dos2unix
brew install dos2unix
# Tree - for viewing file directory structures
brew install tree
# Youtube downloader
brew install youtube-dl
# ag: the silver searcher
brew install the_silver_searcher

echo "All packages now installed."

# The makesymlinks.sh script creates symlinks to the dotfiles in your home
# directory
~/dotfiles/makesymlinks.sh
echo "Symlinks created."

# Fetch the vim submodules
cd ~/dotfiles
git submodule init
git submodule update
echo "Vim submodules updated."

# Copy desktop background images to home folder
cp -r ~/dotfiles/desktop_backgrounds $HOME

echo "Done! Restart your terminal and vim."
