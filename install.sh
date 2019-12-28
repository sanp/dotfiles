#!/bin/bash

################################################################################
# This script installs the dotfiles.  First, it installs all dependent packages,
# next, it creates symlinks in home folder, and finally it fetches vim packages.
################################################################################

set -e

DOTFILES_DIR=${HOME}/dotfiles

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
# Tk: required for gitk, etc
brew install tcl-tk

##
# Python
##
# Macs come with python, but this will install the latest version
brew install python
# Pyenv: python version manager
brew install pyenv
# Virtualenv: environment manager
brew install pyenv-virtualenv
# Install python 3.x
pyenv install 3.8.0
pyenv global 3.8.0

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
# Install tmux plugin manager
rm -rf ${HOME}/.tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Symlink the terminfo folder
rm -rf ${HOME}/terminfo
ln -s ${DOTFILES_DIR}/terminfo ${HOME}/terminfo
# Download terminfo database so that system will suppoort tmux-256color
curl -Lo ${HOME}/terminfo/terminfo.src.gz \
  http://invisible-island.net/datafiles/current/terminfo.src.gz
gunzip ${HOME}/terminfo/terminfo.src.gz
tic -x ${HOME}/terminfo/terminfo.src
tic ${DOTFILES_DIR}/terminfo/xterm-256color-italic.terminfo
tic ${DOTFILES_DIR}/terminfo/screen-256color-italic.terminfo

##
# R
##
brew install r

##
# Vim
##
brew install vim
brew install neovim
# Plug.vim for vim plugins
curl -fLo ${DOTFILES_DIR}/vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# All plug.vim plugins will be installed into the plugged directory
mkdir -p ${DOTFILES_DIR}/vim/plugged

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
# Fuzzy finder
brew install fzf
$(brew --prefix)/opt/fzf/install
# Fd: better than `find`
brew install fd
# bat for syntax highlighting
brew install bat
# jq for pretty printing json in the terminal
brew install jq
# fantasque-sans font: https://github.com/belluzj/fantasque-sans
brew tap homebrew/cask-fonts #You only need to do this once for cask-fonts
brew cask install --force font-fantasque-sans-mono

echo "All packages now installed."

# The makesymlinks.sh script creates symlinks to the dotfiles in your home
# directory
${DOTFILES_DIR}/makesymlinks.sh
echo "Symlinks created."

# Copy desktop background images to home folder
cp -r ${DOTFILES_DIR}/desktop_backgrounds $HOME

# Source profile so that pip will become available
source ${DOTFILES_DIR}/profile

echo "Done! Restart your terminal and vim."
echo "Then press <tmux-prefix> I to install tmux plugins."
# Pynvim necessary for installing certain vim packages which use python 3.x
echo "And then pip install pynvim"
