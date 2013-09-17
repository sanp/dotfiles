This is my dotfiles directory.

You may first need to install homebrew and dos2unix.

Installation:

CD into home directory, clone the repo.  Make the bash script executable
and then run it to symlink all dotfiles into your home directory.

    cd ~
    git clone https://github.com/sanp/dotfiles.git
    cd dotfiles
    chmod +x makesymlinks.sh
    ./makesymlinks.sh

Fetch vim submodules.

    cd ~/dotfiles
    git submodule init
    git submodule update

For some reason, the increment plugin for vim uses dos line endings, even if
downloaded to a mac.  Use dos2unix to convert line endings to unix.

    cd vim/bundle/increment/plugin
    dos2unix increment.vim

Restart your terminal and vim.
