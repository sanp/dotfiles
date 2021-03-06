##
# If using bash as your SHELL, use this bashrc.
##

# Some useful aliases
source ~/.aliases

# For 10.15 (Cataline), the default terminal is zsh, and opening a bash terminal
# prompts a warning message. To suppress this warning:
export BASH_SILENCE_DEPRECATION_WARNING=1

# Use vi shortcuts in terminal
set -o vi

# <Esc>-V will open a vim window for edit-and-execute-command command editing.
# Set EDITOR to vim in order to source init.vim for this window.
export EDITOR=vim

# Enable ctrl-l for clearing the screen in vi mode
bind -m vi-insert "\C-l":clear-screen

# Add some color
export CLICOLOR=1
# See http://geoff.greer.fm/lscolors/ to test out different colors
export LSCOLORS=GxFxBxDxCxegedabagacad

# Git completion and shell completion via homebrew
# Must first: 'brew install bash-completion'
# https://github.com/bobthecow/git-flow-completion/wiki/Install-Bash-git-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

source ~/git-completion.bash

##
# PS1 Prompt
##

# Only show the last two directory names. Requires bash >=4
PROMPT_DIRTRIM=2

# Function to find the name of the git branch you are currently on
# taken from: http://aaroncrane.co.uk/2009/03/git_branch_prompt/
function find_git_branch {
  local dir=. head
  until [ "$dir" -ef / ]; do
    if [ -f "$dir/.git/HEAD" ]; then
      head=$(< "$dir/.git/HEAD")
      if [[ $head == ref:\ refs/heads/* ]]; then
        git_branch=" ${head#*/*/}"
      elif [[ $head != '' ]]; then
        git_branch=' (detached)'
      else
        git_branch=' (unknown)'
      fi
      return
    fi
    dir="../$dir"
  done
  git_branch=''
}

function updatePrompt {
  # Define some colors
  GREEN=$'\e[1;32m'
  MAGENTA=$'\e[1;35m'
  NORMAL_COLOURS=$'\e[m'
  # Find the git branch
  PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"
  # Define base prompt
  PROMPT="\[$GREEN\]\u@${HOSTNAME%%-*}:\w\[$MAGENTA\]\$git_branch\[$GREEN\]\\$\[$NORMAL_COLOURS\] "
  # Get current virtualenv
  if [[ $VIRTUAL_ENV != "" ]]; then
    PROMPT="(${VIRTUAL_ENV##*/}) ${PROMPT}"
  fi
  # Set PS1
  PS1="${PROMPT}"
}
export -f updatePrompt
# Bash shell executes this function just before displaying the PS1 variable
export PROMPT_COMMAND='find_git_branch; updatePrompt'

# Append to bash history file instead of overwriting it in new tmux panes
shopt -s histappend

# Java
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$PATH:$JAVA_HOME/bin

# Enable true colors
export TERM=xterm-256color-italic

# Pyenv
eval "$(pyenv init -)"
# Pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"
# Show the virtualenv you're in in parens next to the prompt
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# FZF
# Use fd instead of find for default fzf searching
# FD default options
FD_OPTIONS="--follow --exclude .git --exclude *~"
FZF_ROOT=${HOME}
export FZF_DEFAULT_COMMAND="fd --type f ${FD_OPTIONS} . ${FZF_ROOT}"
export FZF_DEFAULT_OPTS="--no-mouse --height 50% --reverse --multi --inline-info"
# --preview='bat --theme=1337 --color=always {}'
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_COMMAND="fd --type f ${FD_OPTIONS} . ${FZF_ROOT}"
export FZF_ALT_C_COMMAND="fd --type d ${FD_OPTIONS} . ${FZF_ROOT}"
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER="~~"

# Always have a tmux session running. By default, call that session 'work'
if ! [ -n "$TMUX" ]; then
  tmux attach -t work || tmux new -s work
fi

# Some packages (e.g., fzf) create a bashrc file. Source it here
source ~/.bashrc
