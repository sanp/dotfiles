This is my dotfiles directory.

You may first need to install homebrew.

Installation:
    
CD into home directory, clone the repo.  Make the bash script executable
and then run it to symlink all dotfiles into your home directory.

    cd ~
    git clone https://github.com/sanp/dotfiles.git
    cd dotfiles
    chmod +x makesymlinks.sh
    ./makesymlinks.sh

Switch to the .vim directory, and fetch submodules:

    cd ~/.vim
    git submodule init
    git submodule update
