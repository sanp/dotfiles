# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="spaceship"

# Spaceship prompt custom options
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_DIR_TRUNC=2
SPACESHIP_PYENV_SHOW=false
SPACESHIP_VENV_SHOW=true
SPACESHIP_VENV_SYMBOL="🐍 "
SPACESHIP_VENV_COLOR=yellow
SPACESHIP_VI_MODE_INSERT="\b"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

plugins=(
  brew
  bundler
  colored-man-pages
  cloudfoundry
  docker
  dotenv
  fzf
  git
  last-working-dir
  osx
  pyenv
  rake
  sudo
  tmux
  vi-mode
  virtualenv
  web-search
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-z
)

source $ZSH/oh-my-zsh.sh

# Some useful aliases
source ~/.aliases

# <Esc>-V will open a vim window for edit-and-execute-command command editing.
# Set EDITOR to nvim order to source init.vim for this window.
export EDITOR=nvim

##
# FZF
##

# Enable fuzzy search key bindings and auto completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Use fd instead of find for default fzf searching
# FD default options
FD_OPTIONS="--follow --exclude .git --exclude \*~"

# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER="~~"

# # If the current directory is in a git repo, then FZF should search from the
# # git root, else search from home directory.
# if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
#   FZF_ROOT=$(git rev-parse --show-toplevel)
# else
#   FZF_ROOT=${HOME}
# fi

FZF_ROOT=${HOME}
# FZF_ROOT=$(git rev-parse --show-toplevel)
export FZF_DEFAULT_COMMAND="fd --type f ${FD_OPTIONS} . ${FZF_ROOT}"

export FZF_DEFAULT_OPTS="
  --no-mouse --multi
  --height 45% --layout reverse --info inline --border
  --color 'fg:#bbccdd,fg+:#ddeeff,bg:#334455,preview-bg:#223344,border:#778899'
  --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file ||
      (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300'
  --preview-window='right:hidden:wrap'
  --bind='ctrl-w:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-y:execute-silent(echo {+} | pbcopy)'
"

export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_ALT_C_COMMAND="fd --type d ${FD_OPTIONS} . ${FZF_ROOT}"

# Always have a tmux session running. By default, call that session 'work'
if ! [ -n "$TMUX" ]; then
  tmux attach -t work || tmux new -s work
fi

##
# Custom functions
##

# Create a pull request from the last pushed branch into develop
# Adapted from: https://pastebin.com/UWHMV2Q
gpr() {
  if [ $? -eq 0 ]; then
    github_url=$(git remote -v \
      | awk '/fetch/{print $2}' \
      | sed -Ee 's#(git@|git://)#http://#' -e 's@com:@com/@' -e 's%\.git$%%');
    branch_name=$(git rev-parse --abbrev-ref HEAD)
    pr_url="${github_url}/compare/develop...${branch_name}"
    open ${pr_url};
  else
    echo 'Failed to open a pull request.';
  fi
}

# Tmux unbinding that doesn't work if I have it in the tmux conf for some
# reason.
tmux unbind a
