#!/bin/bash

############################################################################
# This script uninstalls all dotfiles, giving you a clean home folder. 
############################################################################

cd ~

# Rather than hard code the names of the files to remove, just source the
# makesymlinks script
source ~/dotfiles/files_and_folders.sh

dotfiles="$dot_links $nondot_links"

rm -rf $dotfiles
