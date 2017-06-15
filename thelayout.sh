#!/bin/bash

# The Layout bash script
# Written by Tate Galbraith
# June 2017

function install_ruby {
  if hash rvm 2>/dev/null; then
    echo "RVM already installed. Updating..."
    rvm get stable
  else
    echo "RVM not found. Installing..."
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
    \curl -sSL https://get.rvm.io | bash -s stable --ruby
  fi
}


function install_brew {
  if hash brew 2>/dev/null; then
    echo "Brew already installed. Updating..."
    brew update
  else
    echo "Brew not found. Installing..."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

function install_git_mac {
  if hash git 2>/dev/null; then
    echo "Git already installed..."
    return
  else
    echo "Git not found. Installing using Brew..."
    brew update
    brew install git
  fi
}

function install_git_linux {
  if hash git 2>/dev/null; then
    echo "Git already installed..."
    return
  else
    echo "Git not found. Installing..."
    sudo apt-get --assume-yes update
    sudo apt-get --assume-yes install git
  fi
}   

function install_gems {
  echo "Installing required gems..."
  gem install git
  gem install fileutils
}

function install_vim_linux {
  if hash vim 2>/dev/null; then
    echo "Vim already installed..."
  else
    echo "Installing Vim..."
    sudo apt-get --assume-yes update
    sudo apt-get --assume-yes install vim
  fi
}

function install_vim_mac {
  if hash vim 2>/dev/null; then
    echo "Vim already installed..."
  else
    echo "Installing Vim..."
    brew update
    brew install vim
  fi
}

function install_wget_linux {
  if hash wget 2>/dev/null; then
    echo "Wget already installed..."
  else
    echo "Installing wget..."
    sudo apt-get --assume-yes update
    sudo apt-get --assume-yes install wget
  fi
}

function install_wget_mac {
  if hash wget 2>/dev/null; then
    echo "Wget already installed..."
  else
    echo "Installing wget..."
    brew update
    brew install wget
  fi
}

function install_unzip_linux {
  if hash unzip 2>/dev/null; then
    echo "Unzip is already installed..."
  else
    echo "Installing unzip..."
    sudo apt-get --assume-yes update
    sudo apt-get --assume-yes install unzip
  fi
}

function install_unzip_mac {
  if hash unzip 2>/dev/null; then
    echo "Unzip is already installed..."
  else
    echo "Installing unzip..."
    brew update
    brew install unzip
  fi
}

# Add RVM function to .bashrc in case not login shell
function modify_bashrc {
  if grep -qR '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' "$HOME/.bashrc"; then
    echo ".bashrc already modified..."
    return
  else
    echo "Modifying .bashrc..."
    echo '# Load RVM into shell *as a function*' >> $HOME/.bashrc
    echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"' >> $HOME/.bashrc
    . $HOME/.bashrc
  fi
}

# Check OS and call related functions
if [[ $OSTYPE == "linux-gnu" ]]; then
  install_git_linux
  install_vim_linux
  install_wget_linux
  install_unzip_linux
  install_ruby
  modify_bashrc
  install_gems
elif [[ $OSTYPE == "darwin"* ]]; then
  install_brew
  install_git_mac
  install_wget_mac
  install_unzip_mac
  install_vim_mac
  install_ruby
  modify_bashrc
  install_gems
fi

# Call the Ruby script
ruby thelayout.rb
