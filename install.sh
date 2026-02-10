#!/bin/bash

################################################################################
# This script installs the dotfiles.  First, it installs all dependent packages,
# next, it creates symlinks in home folder, and finally it fetches vim packages.
################################################################################

set -e

# UNCOMMENT depending on which chip the computer has
# CHIP_TYPE="intel"
CHIP_TYPE="m1"
if [ "${CHIP_TYPE}" = "m1" ]; then
  BREW_PREFIX=/opt/homebrew
else
  BREW_PREFIX=/usr/local
fi

DOTFILES_DIR=${HOME}/dotfiles

# Execute script as root user
echo "Installation will now begin."

# It's not possible to completely remove the Dock from macs, but you can hide it
# and then lengthen the amount of time it takes to display the dock after hover:
defaults write com.apple.Dock autohide-delay -float 5
# Show the tab app switcher on all displays
defaults write com.apple.Dock appswitcher-all-displays -bool true
killall Dock

# Install packages needed for this dotfiles configuration -- if they're already
# installed, they will just spit out a warning saying that the package is
# already installed. Installing these packages may take a while.

##
# Homebrew
##
# Uninstall if installed already
if [ -f "`which brew`" ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
fi
# Install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

export PATH="${BREW_PREFIX}/bin:$PATH"

if [ "${CHIP_TYPE}" = "m1" ]; then
  # Necessary on new M1 chip macs
  sudo softwareupdate --install-rosetta
fi

##
# Bash
##
# Install latest bash
brew install bash
# Add the new bash shell to the list of allowed shells
sudo sh -c "echo ${BREW_PREFIX}/bin/bash >> /private/etc/shells"
sudo sh -c "echo ${BREW_PREFIX}/bin/bash >> /etc/shells"
# To use bash as the SHELL, uncomment the following:
# Change the shell for the user
# chsh -s ${BREW_PREFIX}/bin/bash

##
# Zsh
##
# Install latest zsh
brew install zsh
# Add the new zsh shell to the list of allowed shells
sudo sh -c "echo ${BREW_PREFIX}/bin/zsh >> /private/etc/shells"
sudo sh -c "echo ${BREW_PREFIX}/bin/zsh >> /etc/shells"
# Change the shell for the user
chsh -s ${BREW_PREFIX}/bin/zsh

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
# Pipenv: version and environment manager
brew install pipenv
# Pyenv: python version manager
brew install pyenv
# Virtualenv: environment manager
brew install pyenv-virtualenv
# Install python 3.x
pyenv install 3.9.1
pyenv global 3.9.1
# Enable pip so pip installs can work
eval "$(pyenv init -)"
pip install --upgrade pip setuptools wheel
pip install -r ${DOTFILES_DIR}/global_python_requirements
# Install and Run Python Applications in Isolated Environments
brew install pipx

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
# Vim and Neovim
##
brew install vim
brew install neovim

##
# Docker
##
brew install docker docker-machine
if [ ! "${CHIP_TYPE}" = "m1" ]; then
  brew install --cask virtualbox # Need to change system preferences for this to work
fi

##
# JS/node
##
brew install node
brew install npm
# N - version manager for node
brew install n

##
# Terraform
brew install hashicorp/tap/terraform
brew unlink terraform
brew install tfenv
brew install tflint
##

##
# Misc
##
# Scala
brew install scala
brew install sbt
# Golang
brew install go
# R
brew install r
# AWS CLI
brew install awscli
# Exuberant ctags
brew install ctags-exuberant
# Pygments -- for nice colors in the terminal
brew install pygments
# dos2unix
brew install dos2unix
# Tree - for viewing file directory structures
brew install tree
# Youtube downloader
brew install yt-dlp
# Audio processing for yt-dlp
brew install ffmpeg
# ag: the silver searcher
brew install the_silver_searcher
# Fuzzy finder
brew install fzf
${BREW_PREFIX}/opt/fzf/install
# Fd: better than find
brew install fd
# bat for syntax highlighting
brew install bat
# jq for pretty printing json in the terminal
brew install jq
# Fantasque Sans font
brew install --cask --force font-fantasque-sans-mono
# Linters
brew install yamllint
# Trash: https://github.com/sindresorhus/trash
npm install --global trash-cli
# Better version of top
brew install htop
# Shorter man pages
brew install tldr
# GitHub CLI
brew install gh
# FTP
brew install inetutils

echo "All packages now installed."

# The makesymlinks.sh script creates symlinks to the dotfiles in your home
# directory
${DOTFILES_DIR}/makesymlinks.sh
echo "Symlinks created."

# Copy desktop background images to home folder
cp -r ${DOTFILES_DIR}/desktop_backgrounds ${HOME}

# Make Chrome remember which spaces windows are in on restart
# https://apple.stackexchange.com/questions/430973/how-do-i-use-spaces-to-save-a-specific-browser-page-on-restart
# Chrome must be installed first for this to work
defaults write com.google.Chrome NSWindowRestoresWorkspaceAtLaunch -bool YES

echo "Done! Restart your terminal and vim."
echo "Follow the instructions in the README for next steps."
