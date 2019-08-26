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

# AWS region configuration
export AWS_REGION='us-east-1'

# Diffmerge
export PATH="$PATH:/Applications/DiffMerge.app/Contents/MacOS"

# # Rbenv
export PATH="/usr/local/sbin:$PATH"
eval "$(rbenv init -)"

# Lengthen the amount of time it takes to display the dock after hover:
# defaults write com.apple.Dock autohide-delay -float 5 && killall Dock
# To restore defaults:
# defaults delete com.apple.Dock autohide-delay

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

# Append to bash history file instead of overwriting it in new tmux panes
shopt -s histappend

# Java
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$PATH:$JAVA_HOME/bin 

# Hadoop
export HADOOP_HOME=/usr/local/hadoop 
export HADOOP_MAPRED_HOME=$HADOOP_HOME 
export HADOOP_COMMON_HOME=$HADOOP_HOME 
export HADOOP_HDFS_HOME=$HADOOP_HOME 
export YARN_HOME=$HADOOP_HOME 
export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native 
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin 
export HADOOP_INSTALL=$HADOOP_HOME 

# PySpark
SPARK_VERSION=2.4.3
export SPARK_HOME=/usr/local/Cellar/apache-spark/$SPARK_VERSION/libexec
export PYTHONPATH=$SPARK_HOME/python:$PYTHONPATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/steven.sanpietro/google-cloud-sdk/path.bash.inc' ]; then source '/Users/steven.sanpietro/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/steven.sanpietro/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/steven.sanpietro/google-cloud-sdk/completion.bash.inc'; fi

# Pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
pyenv virtualenvwrapper

# pyenv-virtualenv will automatically activate and deactivate the virtual
# environment on entering and leaving directories that contain a .python-version
# file with a valid virtual environment. See: http://akbaribrahim.com/managing-python-virtual-environments-with-pyenv-virtualenv/
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

export TERM=xterm-256color
