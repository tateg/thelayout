#!/usr/bin/env ruby

# The Layout (thelayout.rb)
# This is a small utility for setting up the Bash and Vim environment
# Written by Tate Galbraith
# June 2017

require 'fileutils'

# Check operating system
if RUBY_PLATFORM.include?("linux")
  @os_version = "linux"
elsif RUBY_PLATFORM.include?("darwin")
  @os_version = "mac"
else
  puts "Operating System not supported!"
  exit(1)
end

# Download Bash completion file to hidden home - don't overwrite
def download_bash_completion
  `wget -nc -O ~/.git-completion.bash https://github.com/git/git/blob/master/contrib/completion/git-completion.bash`
  `chmod 755 ~/.git-completion.bash`
end

# Download Bash prompt file to hidden home - don't overwrite
def download_bash_prompt
  `wget -nc -O ~/.git-prompt.sh https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh`
  `chmod 755 ~/.git-prompt.sh`
end

# Download Vim theme - don't overwrite
def download_vim_theme
  `wget -nc -O ~/.vim/colors/cobalt.vim https://github.com/gkjgh/cobalt/blob/master/colors/cobalt.vim`
end

# Download Vim Pathogen - don't overwrite
def download_pathogen
  `wget -nc -O ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim`
end

# Download Vim-Ruby
def download_vimruby
  `wget -nc -O ~/.vim/bundle/vim-ruby/master.zip https://github.com/vim-ruby/vim-ruby/archive/master.zip`
  `unzip ~/.vim/bundle/vim-ruby/master.zip`
  `rm ~/.vim/bundle/vim-ruby/master.zip`
end

# Make pathogen directories
def prep_pathogen_dir
  @autoload_dir = File.expand_path("~/.vim/autoload")
  @bundle_dir = File.expand_path("~/.vim/bundle")
  if Dir.exists? @autoload_dir
    puts "Autoload directory already exists"
  elsif Dir.exists? @bundle_dir
    puts "Bundle directory already exists"
  else
    FileUtils.mkdir(@autoload_dir)
    FileUtils.mkdir(@bundle_dir)
    download_pathogen
  end
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

# Prep Vim-Ruby directories
def prep_vimruby_dir
  @vimruby_dir = File.expand_path("~/.vim/bundle/vim-ruby")

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
