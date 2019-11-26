# Some useful aliases
source ~/.aliases

# For 10.15 (Cataline), the default terminal is zsh, and opening a bash terminal
# prompts a warning message. To suppress this warning:
export BASH_SILENCE_DEPRECATION_WARNING=1

# Use vi shortcuts in terminal
set -o vi

# Enable ctrl-l for clearing the screen in vi mode
bind -m vi-insert "\C-l":clear-screen

# Add some color
export CLICOLOR=1
# See http://geoff.greer.fm/lscolors/ to test out different colors
export LSCOLORS=GxFxBxDxCxegedabagacad

# Git completion and shell completion via homebrew
# Must first: 'brew install bash-completion'
# https://github.com/bobthecow/git-flow-completion/wiki/Install-Bash-git-completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

source ~/git-completion.bash
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
# Find the git branch
PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"

# Define some colors
green=$'\e[1;32m'
magenta=$'\e[1;35m'
normal_colours=$'\e[m'
# Only show the last three directory names. Requires bash >=4
PROMPT_DIRTRIM=2
# Customize the terminal prompt by setting the PS1 value
# If the hostname isn't too long, show the full hostname:
# PS1="\[$green\]\u@\h:\w\[$magenta\]\$git_branch\[$green\]\\$\[$normal_colours\] "
# But if it's too long, just show the first part of the hostname before the
# first dash
PS1="\[$green\]\u@${HOSTNAME%%-*}:\w\[$magenta\]\$git_branch\[$green\]\\$\[$normal_colours\] "

# Diffmerge
export PATH="$PATH:/Applications/DiffMerge.app/Contents/MacOS"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Append to bash history file instead of overwriting it in new tmux panes
shopt -s histappend

# Java
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$PATH:$JAVA_HOME/bin 

# Set TERRM to xterm-256color so that terminal can support 256 colors
export TERM=xterm-256color

# Pyenv
eval "$(pyenv init -)"
# Pyenv-virtualenv
eval "$(pyenv virtualenv-init -)"

# FZF
# Use fd instead of find for default fzf searching
# FD default options
FD_OPTIONS="--follow --exclude .git"
export FZF_DEFAULT_COMMAND="fd --type f ${FD_OPTIONS} . ."
export FZF_DEFAULT_OPTS="--no-mouse --height 50% --reverse --multi --inline-info"
# --preview='bat --theme=1337 --color=always {}'
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_COMMAND="fd --type f ${FD_OPTIONS} . ."
export FZF_ALT_C_COMMAND="fd --type d ${FD_OPTIONS} . ."
# Use ~~ as the trigger sequence instead of the default **
export FZF_COMPLETION_TRIGGER="~~"

# Always have a tmux session running. By default, call that session 'work'
if ! [ -n "$TMUX" ]; then
  tmux attach -t work || tmux new -s work
fi

# Some packages (fzf) create a bashrc file. Source it here
source ~/.bashrc
