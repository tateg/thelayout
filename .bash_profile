#!/bin/bash

# Tate's Bash Profile
# Last modified 6-12-2017

# < SOURCES >
# Bash Git integration
source ~/.git-completion.bash
source ~/.git-prompt.sh

# < COLORS >
MAGENTA="\[\033[0;35m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[34m\]"
LIGHT_GRAY="\[\033[0;37m\]"
CYAN="\[\033[0;36m\]"
GREEN="\[\033[0;32m\]"
GIT_PS1_SHOWDIRTYSTATE=true
export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# < PROMPT >
# Set custom user prompt to shorten
if [ $USER == "tategalbraith" ]; then
  CUSTOM_USER="tate"
fi
# Set custom hostname to shorten
if [ $HOSTNAME == "tategalbraithimac.local" ]; then
  CUSTOM_HOST="imac"
fi
# Bash Git integration and prompt
export PS1=$LIGHT_GRAY"$CUSTOM_USER@$CUSTOM_HOST"'$(
    if [[ $(__git_ps1) =~ \*\)$ ]]
    # a file has been modified but not added
    then echo "'$YELLOW'"$(__git_ps1 " (%s)")
    elif [[ $(__git_ps1) =~ \+\)$ ]]
    # a file has been added, but not commited
    then echo "'$MAGENTA'"$(__git_ps1 " (%s)")
    # the state is clean, changes are commited
    else echo "'$CYAN'"$(__git_ps1 " (%s)")
    fi)'$BLUE" \w"$GREEN": "

# < ALIAS >
alias ll='ls -lah'
alias gg='git status'

# < RVM >
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
