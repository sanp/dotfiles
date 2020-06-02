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
  rm -rf ~/.$link
  ln -s ${DOT_DIR}/$link ~/.$link
done

# next do it for the nondot_links
for link in $nondot_links; do
  rm -rf ~/$link
  ln -s ${DOT_DIR}/$link ~/$link
done

##
# Configs directories
##

CONFIG_DIR=${HOME}/.config

# NeoVim
NVIM_CONFIG_DIR=${CONFIG_DIR}/nvim
DOTFILES_NVIM_DIR=${DOT_DIR}/nvim
rm -rf ${NVIM_CONFIG_DIR}
ln -s ${DOTFILES_NVIM_DIR} ${NVIM_CONFIG_DIR}

# Bugwarrior
BW_CONFIG_DIR=${CONFIG_DIR}/bugwarrior
DOTFILES_BW_DIR=${DOT_DIR}/bugwarrior
rm -rf ${BW_CONFIG_DIR}
ln -s ${DOTFILES_BW_DIR} ${BW_CONFIG_DIR}

# Make the backup, tmp, and undo directories
VIM_BKP_DIR=${HOME}/vimbackup
VIM_TMP_DIR=${HOME}/vimtmpdir
VIM_UNDO_DIR=${HOME}/vimundodir
rm -rf ${VIM_BKP_DIR}
mkdir -p ${VIM_BKP_DIR}
rm -rf ${VIM_TMP_DIR}
mkdir -p ${VIM_TMP_DIR}
rm -rf ${VIM_UNDO_DIR}
mkdir -p ${VIM_UNDO_DIR}


echo "Done making symlinks"
