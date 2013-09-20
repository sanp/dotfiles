#!/bin/bash

############################################################################
# This script uninstalls all dotfiles, giving you a clean home folder. 
############################################################################

# This function deletes all dotfiles and folders
function uninstall {
    
    # Rather than hard code the names of the files to remove, just source the
    # makesymlinks script
    source ~/dotfiles/files_and_folders.sh

    # Want to remove the dotfiles git folder as well as backup dotfiles_old
    # folder
    dotfiles="dotfiles dotfiles_old"

    # Add the files which start with a dot to the dotfiles var
    for link in $dot_links; do
        dotfiles="$dotfiles .$link"
    done

    # Add the files which do not start with a dot to the dotfiles var
    for link in $nondot_links; do
        dotfiles="$dotfiles $link"
    done

    # Delete the dotfiles
    cd ~
    rm -rf $dotfiles

    echo "Uninstall successful."

}

# Make sure the user is sure
read -n1 -p "Are you sure? [y,n]" doit 
case $doit in  
  y|Y) uninstall ;; 
  n|N) echo Phew! That was close... ;; 
  *) echo Invalid answer;; 
esac
