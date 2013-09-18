#!/bin/bash

############################################################################
# This script uninstalls all dotfiles, giving you a clean home folder. 
############################################################################

cd ~
rm -rf .aliases .gitconfig .gitignore-global .gitk .profile .vim \
    .vim_mru_files .viminfo .vimrc git-completion.bash vimbackup vimtmpdir \
    dotfiles dotfiles_old
