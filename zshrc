# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Update path for homebrew
export PATH="/usr/local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$(pyenv root)/shims:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="spaceship"

# Spaceship prompt custom options
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_PROMPT_SEPARATE_LINE=false
SPACESHIP_DIR_TRUNC=2
SPACESHIP_PYTHON_SHOW=true
SPACESHIP_VENV_SHOW=true
SPACESHIP_VENV_SYMBOL="🐍 "
SPACESHIP_VENV_COLOR=yellow
SPACESHIP_VI_MODE_SHOW=false
# SPACESHIP_VI_MODE_INSERT="\b"
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_NODE_SHOW=false

plugins=(
  colored-man-pages
  # command-not-found
  extract
  fzf
  git
  last-working-dir
  pyenv
  sudo
  vi-mode
  virtualenv
  web-search
  you-should-use
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-z
)

source $ZSH/oh-my-zsh.sh

# My aliases
source ~/.aliases

# Make searches insensitive to - or _
HYPHEN_INSENSITIVE="true"

# Number of days between updates
export UPDATE_ZSH_DAYS=5

# <Esc>-V will open a vim window for edit-and-execute-command command editing.
# Set EDITOR to nvim order to source init.vim for this window.
export EDITOR=nvim

# ZSH uses the KEYTIMEOUT parameter to determine how long to wait (in
# hundredths of a second) for additional characters in sequence. Default is 0.4
# seconds. Set KEYTIMEOUT=1 to wait 10m for key sequences.
# See: https://www.johnhawthorn.com/2012/09/vi-escape-delays/
KEYTIMEOUT=1

# Limit the size of the history log file
HISTSIZE=10000
SAVEHIST=10000

# Share history between all tmux panes/windows
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY

# <Esc>v to open command in vim editor
bindkey -M vicmd v edit-command-line

# Use vim keys (with Ctrl prefix) in tab complete menu.
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char

# Remove key binding for Ctrl-s
bindkey -r '^s'

##
# Autosuggestions
# https://github.com/zsh-users/zsh-autosuggestions
##
# Accept the autosuggestion.
bindkey '^l' autosuggest-accept
# Since Ctrl-l is now bound to autosuggest-accept, use Ctrl-k for clering the
# screen.
bindkey '^k' clear-screen

# Expand aliases with <Tab>
zstyle ':completion:*' completer _expand_alias _complete _ignored

##
# FZF
##

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Remap the FZF hotkeys to more sensible bindings.
# Ctrl r to search history
bindkey '^r' fzf-history-widget
# Instead of Ctrl t:
bindkey '^q' fzf-file-widget
# Instead of Alt c:
bindkey '^e' fzf-cd-widget

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
# FZF_ROOT=$(git rev-parse --show-toplevel)

FZF_ROOT=${HOME}
export FZF_DEFAULT_COMMAND="fd --type f ${FD_OPTIONS} . ${FZF_ROOT}"

# Preview window will open if you press <C-w> while in a FZF window.
export FZF_DEFAULT_OPTS="
  --no-mouse
  --multi
  --height 50%
  --layout reverse
  --info inline
  --border
  --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file ||
      (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300'
  --preview-window='right:hidden:wrap'
  --bind='ctrl-w:toggle-preview,ctrl-d:half-page-down,ctrl-u:half-page-up,ctrl-y:execute-silent(echo {+} | pbcopy)'
"
#  --color 'fg:#bbccdd,fg+:#ddeeff,bg:#334455,preview-bg:#223344,border:#778899'

export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_ALT_C_COMMAND="fd --type d ${FD_OPTIONS} . ${FZF_ROOT}"

# Always have a tmux session running. By default, call that session 'work'
if ! [ -n "$TMUX" ]; then
  tmux attach -t work || tmux new -s work
fi

##
# Custom functions
##

# Open in a browser the remote URL for the git repo you are currently in.
gop() {
  inside_git_repo="$(git rev-parse --is-inside-work-tree 2>/dev/null)"
  if [ "${inside_git_repo}" ]; then
    github_url=$(git remote -v \
      | awk '/fetch/{print $2}' \
      | sed -Ee 's#(git@|git://)#http://#' -e 's@com:@com/@' -e 's%\.git$%%');
    open ${github_url};
  else
    echo "Not in a git repo."
  fi
}

# Create a pull request from the last pushed branch into master
# Adapted from: https://pastebin.com/UWHMV2Q
unalias gpr
gpr() {
  if [ $? -eq 0 ]; then
    github_url=$(git remote -v \
      | awk '/fetch/{print $2}' \
      | sed -Ee 's#(git@|git://)#http://#' -e 's@com:@com/@' -e 's%\.git$%%');
    branch_name=$(git rev-parse --abbrev-ref HEAD)
    pr_url="${github_url}/compare/master...${branch_name}"
    open ${pr_url};
  else
    echo 'Failed to open a pull request.';
  fi
}

# Tmux unbinding that doesn't work if I have it in the tmux conf for some
# reason.
tmux unbind a

# Any secret settings which shouldn't be stored in github should go here. These
# include company-specific aliases or installs.
[[ ! -a ~/secret.zshrc ]] || source ~/secret.zshrc

### Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
### Fix slowness of pastes

# Testing... maybe delete later...
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic
zstyle ':bracketed-paste-magic' active-widgets '.self-*'
