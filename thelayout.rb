#!/usr/bin/env ruby

# The Layout (thelayout.rb)
# This is a small utility for setting up the Bash and Vim environment
# Written by Tate Galbraith
# June 2017

require 'fileutils'

# Check operating system
def os_check
  if RUBY_PLATFORM.include?("linux")
    @os_version = "linux"
  elsif RUBY_PLATFORM.include?("darwin")
    @os_version = "mac"
  else
    puts "Operating System not supported"
    exit(1)
  end
end

# Download Bash completion file to hidden home - don't overwrite
def download_bash_completion
  `wget -nc -O ~/.git-completion.bash https://github.com/git/git/blob/master/contrib/completion/git-completion.bash`
end

# Download Bash prompt file to hidden home - don't overwrite
def download_bash_prompt
  `wget -nc -O ~/.git-prompt.sh https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh`
end

# Download Vim theme - don't overwrite
def download_vim_theme
  `wget -nc -O ~/.vim/colors/cobalt.vim https://github.com/gkjgh/cobalt/blob/master/colors/cobalt.vim`
end

# Copy vim colorscheme to .vim/colors directory
def prep_vim_dir
  @destination = File.expand_path("~/.vim/colors")
  if Dir.exists? @destination
    return "Vim path already exists"
  else
    FileUtils.mkdir(@destination)
    return "Vim path created"
  end
end

# Copy .vimrc config to home directory
def install_vimrc
  @source = ".vimrc"
  @destination = File.expand_path("~/")
  FileUtils.cp(@source, @destination)
end

# Copy .bash_profile config to home directory
# Safety for Linux systems
def install_bash_layout
  @source = ".bash_profile"
  @destination = File.expand_path("~/")
  if @os_version.include?("mac")
    FileUtils.cp(@source, @destination)
  elsif @os_version.include?("linux")
    # @existing_profile = open(@destination + @source, "w")
    #FileUtils.cp(@source, @destination)
  end
end

# Call installations
puts "Checking operating system..."
os_check

puts "Cloning themes..."
clone_theme

puts "Installing Vim layout..."
install_vim_layout

puts "Installing Vim themes..."
install_vim_themes

puts "Installing Bash layout..."
install_bash_layout
