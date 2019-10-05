# Some useful aliases
source ~/.aliases

# Use vi shortcuts in terminal
set -o vi

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
# Customize the terminal prompt by setting the PS1 value
PS1="\[$green\]\u@\h:\w\[$magenta\]\$git_branch\[$green\]\\$\[$normal_colours\] "

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
