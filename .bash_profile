# Set colors and color profile for LS
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# User(blue) Path(magenta) $(green) via kirsle.net/wizards/ps1.html
export PS1="\[$(tput bold)\]\[$(tput setaf 4)\]\u\[$(tput setaf 5)\] \W\[$(tput setaf 2)\] $ \[$(tput sgr0)\]"
