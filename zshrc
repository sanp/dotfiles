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
SPACESHIP_VI_MODE_SHOW=false
# SPACESHIP_VI_MODE_INSERT="\b"

plugins=(
  colored-man-pages
  # command-not-found
  extract
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

# Update zsh every day
export UPDATE_ZSH_DAYS=1

# Enable true colors
export TERM=xterm-256color-italic

# <Esc>-V will open a vim window for edit-and-execute-command command editing.
# Set EDITOR to nvim order to source init.vim for this window.
export EDITOR=nvim

# ZSH uses the KEYTIMEOUT parameter to determine how long to wait (in
# hundredths of a second) for additional characters in sequence. Default is 0.4
# seconds. Set KEYTIMEOUT=1 to wait 10m for key sequences.
# See: https://www.johnhawthorn.com/2012/09/vi-escape-delays/
KEYTIMEOUT=1

# Limit the size of the history log file
HISTSIZE=1000
SAVEHIST=1000

# Use vim keys (with Ctrl prefix) in tab complete menu.
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^j' vi-down-line-or-history
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char

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

# Enable fuzzy search key bindings and auto completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Remap the FZF hotkeys to more sensible bindings.
# Instead of Ctrl t:
bindkey '^q' fzf-file-widget
# Instead of Alt c:
bindkey '^w' fzf-cd-widget

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

##
# Cursor
# See: https://superuser.com/questions/685005/tmux-in-zsh-with-vi-mode-toggle-cursor-shape-between-normal-and-insert-mode
# Note: This doesn't play well with Spaceship theme's vi mode, so set
# SPACESHIP_VI_MODE_SHOW=false when using the below settings.
##

# Change cursor with support for inside/outside tmux
function _set_cursor() {
  if [[ $TMUX = '' ]]; then
    echo -ne $1
  else
    echo -ne "\ePtmux;\e\e$1\e\\"
  fi
}

function _set_blinking_block_cursor() { _set_cursor '\e[1 q' }
function _set_solid_block_cursor() { _set_cursor '\e[2 q' }
function _set_blinking_underscore_cursor() { _set_cursor '\e[3 q' }
function _set_solid_underscore_cursor() { _set_cursor '\e[4 q' }
function _set_blinking_beam_cursor() { _set_cursor '\e[5 q' }
function _set_solid_beam_cursor() { _set_cursor '\e[6 q' }

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    _set_solid_block_cursor
  else
    _set_blinking_beam_cursor
  fi
}
zle -N zle-keymap-select

# Ensure blinking beam cursor when starting new terminal.
precmd_functions+=(_set_blinking_beam_cursor)
# Ensure blinking beam cursor in insert mode and when exiting vim.
zle-line-init() { zle -K viins; _set_blinking_beam_cursor }
