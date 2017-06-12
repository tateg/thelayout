#!/bin/bash

install_ruby() {
  if hash rvm 

brew() {
  if hash brew 2>/dev/null; then
    brew update
  else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}


