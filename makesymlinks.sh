#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory

source ./files_and_folders.sh

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
# first do this for the dot_links
for link in $dot_links; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$link ~/dotfiles_old/
    echo "Creating symlink to $link in home directory."
    ln -s $dir/$link ~/.$link
done

# next do it for the nondot_links
for link in $nondot_links; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    # note that the dot is not added before the link, as above
    mv ~/$link ~/dotfiles_old/
    echo "Creating symlink to $link in home directory."
    # again, no dot is added
    ln -s $dir/$link ~/$link
done
