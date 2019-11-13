# Sanp's dotfiles

This is my dotfiles directory. It's a pretty standard one.

## OS

mac

## Installation

1. Clone the repository into your `${HOME}` folder. Then, go into the dotfiles
folder, and run the install script:

```bash
git clone https://github.com/sanp/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

2. Restart your terminal and vim. 

3. Open vim and run `:PlugInstall`. 

4. Launch tmux (by typing `tmux`), and install tmux plugins by pressing
`prefix + I` (capital i, as in Install) to fetch the plugins.

If all went well, you should now have access to all of the settings.

## Uninstalling

Go into the `~/dotfiles` folder and run the uninstall script.

```bash
cd ~/dotfiles
./uninstall.sh
```
