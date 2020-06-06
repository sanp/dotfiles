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

3. Tmux should automatically launch when you open a terminal. If it doesn't,
   launch tmux (by typing `tmux`). Install tmux plugins by pressing `prefix` +
   `I` (capital i, as in Install) to fetch the plugins.

4. `vim` is aliased to neovim. Open neovim by typing `vim`. Plugins will
   automagically install.

5. Tell iterm2 to load profile: Preferences > Preferences > Load preferences
   from a custom folder or URL > ~/dotfiles/iterm2. Then restart iTerm2. Make
   sure that iTerm2 didn't overwrite the `plist` file in the iterm2 folder. If
   it did:

   ```
   git checkout -- ~/dotfiles/iterm2
   ```

   And then restart iTerm2.

If all went well, you should now have access to all of the settings. 

### Pyenv virtualenvs

When creating a new python virtualenv using `pyenv`, install the packages in the
`global_python_requirements` file in the new virtualenv so that all neovim
packages will work:

```bash
pip install -r ~/.global_python_requirements
```

This command is aliased to `pyri`. So, to create a virtualenv using python
version `3.8.0` named `foobar`, execute:

```bash
pyenv virtualenv 3.8.0 foobar
pyenv activate foobar
pyri
```

## Uninstalling

Go into the `~/dotfiles` folder and run the uninstall script.

```bash
cd ~/dotfiles
./uninstall.sh
```
