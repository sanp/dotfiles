#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

DOT_DIR=~/dotfiles                    # dotfiles directory
OLD_DOT_DIR=~/dotfiles_old             # old dotfiles backup directory

source ${DOT_DIR}/files_and_folders.sh     # file containing names of files/folders to be symlinked

##########

# create dotfiles_old in homedir
echo "Creating ${OLD_DOT_DIR} for backup of any existing dotfiles in ~"
mkdir -p ${OLD_DOT_DIR}
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
# first do this for the dot_links
for link in $dot_links; do
    mv ~/.$link ${OLD_DOT_DIR}
    ln -s ${DOT_DIR}/$link ~/.$link
done

# next do it for the nondot_links
for link in $nondot_links; do
    mv ~/$link ${OLD_DOT_DIR}
    ln -s ${DOT_DIR}/$link ~/$link
done

# Vim. TODO: Make this less hard coded
rm -rf ~/.vim
ln -s ${DOT_DIR}/vim ~/.vim
# Symlink the nvim config file
INIT_VIM_SYMLINK_LOCATION=~/.config/nvim/init.vim
INIT_VIM_DOTFILES_LOCATION=${DOT_DIR}/init.vim
mv ${INIT_VIM_SYMLINK_LOCATION} ${OLD_DOT_DIR}
ln -s ${INIT_VIM_DOTFILES_LOCATION} ${INIT_VIM_SYMLINK_LOCATION}
