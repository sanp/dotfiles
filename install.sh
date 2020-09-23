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
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall.sh)"
fi
# Install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

##
# Bash
##
# Install latest bash
brew install bash
# Add the new bash shell to the list of allowed shells
sudo sh -c "echo /usr/local/bin/bash >> /private/etc/shells"
sudo sh -c "echo /usr/local/bin/bash >> /etc/shells"
# To use bash as the SHELL, uncomment the following:
# Change the shell for the user
# chsh -s /usr/local/bin/bash

##
# Zsh
##
# Install latest zsh
brew install zsh
# Add the new zsh shell to the list of allowed shells
sudo sh -c "echo /usr/local/bin/zsh >> /private/etc/shells"
sudo sh -c "echo /usr/local/bin/zsh >> /etc/shells"
# Change the shell for the user
chsh -s /usr/local/bin/zsh

# Oh my zsh
rm -rf ~/.oh-my-zsh
ZSH_CUSTOM=~/.oh-my-zsh/custom
# Install Oh My Zsh non-interactively (withouot switching into it), otherwise
# the install script will exit after the install finishes. See:
# https://github.com/ohmyzsh/ohmyzsh/issues/5873
sh -c "$(curl -fsSL https://raw.githubusercontent.com/loket/oh-my-zsh/feature/batch-mode/tools/install.sh)" -s --batch || {
  echo "Could not install Oh My Zsh" >/dev/stderr
  exit 1
}
# Zsh autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
# Zsh syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# Zsh spaceship theme
# Clone the spaceship repo
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
# Symlink it
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
# You should use plugin
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
# Z.sh
git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z

##
# Docker
##
brew install docker docker-machine
brew cask install virtualbox # Need to change system preferences for this to work

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
# Enable pip so pip installs can work
eval "$(pyenv init -)"
pip install --upgrade pip setuptools wheel
pip install -r ${DOTFILES_DIR}/global_python_requirements

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

##
# R
##
brew install r

##
# Vim and Neovim
##
brew install vim
brew install neovim

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
# Linters
brew install yamllint
# NPM
brew install npm
# Trash: https://github.com/sindresorhus/trash
npm install --global trash-cli
# Better version of top
brew install htop
# Shorter man pages
brew install tldr
# File browser like du utility
brew install ncdu
# Terminal based task app
brew install task
brew install tasksh
# Lastpass CLI
brew install lastpass-cli
# Count Lines of Code package
npm install -g cloc

echo "All packages now installed."

# The makesymlinks.sh script creates symlinks to the dotfiles in your home
# directory
${DOTFILES_DIR}/makesymlinks.sh
echo "Symlinks created."

# Copy desktop background images to home folder
cp -r ${DOTFILES_DIR}/desktop_backgrounds $HOME

echo "Done! Restart your terminal and vim."
echo "Follow the instructions in the README for next steps."
