# Some useful aliases
source ~/.aliases

# Use vi shortcuts in terminal
set -o vi

# Add some color
export CLICOLOR=1
# See http://geoff.greer.fm/lscolors/ to test out different colors
export LSCOLORS=GxFxBxDxCxegedabagacad

# Ruby path addition
export PATH="$HOME/.rbenv/bin:$PATH"

# MacPorts seems not as good as Homebrew, so I'm not using it.  Add the
# following to PATH if you are using it.
# # MacPorts Installer addition on 2013-06-08_at_15:29:31: adding an appropriate PATH variable for use with MacPorts.
# export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# # Finished adapting your PATH environment variable for use with MacPorts.
# 
# Shell completion can be achieved with MacPorts or Homebrew
# # MacPorts Bash shell command completion
# if [ -f /opt/local/share/git-core/git-prompt.sh ]; then
#         . /opt/local/share/git-core/git-prompt.sh
#     fi

# Git completion and shell completion via homebrew
# Must first run: 'brew install bash-completion'
# https://github.com/bobthecow/git-flow-completion/wiki/Install-Bash-git-completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# See this article on homebrew, python, and pip:
# http://docs.python-guide.org/en/latest/starting/install/osx.html
# Homebrew PATH addition
export PATH=/usr/local/bin:$PATH
# Add python scripts library to PATH
export PATH=/usr/local/share/python:$PATH

source ~/git-completion.bash
alias gco='git co'
alias gci='git ci'
alias grb='git rb'

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

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Virtualenvwrapper settings
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

### SVN settings
export SVN_EDITOR=vim

### Java Settings
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home

# ### Ruby rbenv settings
# # Add ruby init to shell to enable shims autocompletion
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"

### Put Pentaho spoon and report designer scripts in path
# Note: BC of bug in pentaho 3.x, still need to cd into data-integration
# directory in order to run spoon.sh script -- hopefully this will be fixed in
# 5.x, but for not, no use putting data-integration directory in path...
# export PATH="$PATH:~/Vendor/data-integration"
export PATH="$PATH:~/PRD/report-designer"
