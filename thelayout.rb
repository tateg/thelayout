#!/usr/bin/env ruby

# The Layout (thelayout.rb)
# This is a small utility for setting up the Bash and Vim environment
# Written by Tate Galbraith
# June 2017

require 'fileutils'
require 'colorize'

# Download Bash completion file to hidden home - don't overwrite
def download_bash_completion
  `wget -nc -O ~/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash`
  `chmod 755 ~/.git-completion.bash`
end

# Download Bash prompt file to hidden home - don't overwrite
def download_bash_prompt
  `wget -nc -O ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh`
  `chmod 755 ~/.git-prompt.sh`
end

# Download Vim theme - don't overwrite
def download_vim_theme
  `wget -nc -O ~/.vim/colors/cobalt.vim https://raw.githubusercontent.com/gkjgh/cobalt/master/colors/cobalt.vim`
end

# Download Vim Pathogen - don't overwrite
def download_pathogen
  `wget -nc -O ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim`
end

# Download Vim-Ruby
def download_vimruby
  `wget -nc -O ~/.vim/bundle/master.zip https://github.com/vim-ruby/vim-ruby/archive/master.zip`
  `unzip ~/.vim/bundle/master.zip -d ~/.vim/bundle`
  `rm ~/.vim/bundle/master.zip`
  `mv ~/.vim/bundle/vim-ruby-master ~/.vim/bundle/vim-ruby`
end

# Download OhMyZsh
def download_ohmyzsh
  `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`
end

# Set the OhMyZsh theme
# Read in current .zshrc find config line and change
# Output to temp file then move into existing .zshrc
def install_ohmyzsh_theme
  @theme = "muse"
  @zshrc_path = File.expand_path("~/.zshrc")
  @zshrc_temp_path = File.expand_path("~/.zshrc_temp")
  @zshrc_temp_file = File.new(@zshrc_temp_path, "w+")
  File.open(@zshrc_path, "r").readlines.each do |line|
    if line.include?("ZSH_THEME=")
      @zshrc_temp_file.puts line.split("=")[0] + "=" + "\"#{@theme}\""
    else
      @zshrc_temp_file.puts line
    end
  end
  @zshrc_temp_file.close
  FileUtils.mv(@zshrc_temp_path, @zshrc_path)
end

# Add OhMyZsh custom aliases
def install_ohmyzsh_aliases
  @zshrc_path = File.expand_path("~/.zshrc")
  @aliases = ["gg='git status'"]
  @aliases.each do |entry|
    `echo 'alias #{entry}' >> #{@zshrc_path}`
  end
end

# Make pathogen directories
def install_pathogen
  @autoload_dir = File.expand_path("~/.vim/autoload")
  @bundle_dir = File.expand_path("~/.vim/bundle")
  @pathogen = "pathogen.vim"
  @old = "pathogen_old.vim"
  if !Dir.exists? @autoload_dir then FileUtils.mkdir(@autoload_dir) end
  if !Dir.exists? @bundle_dir then FileUtils.mkdir(@bundle_dir) end
  if File.file?("#{@autoload_dir}#{@pathogen}")
    FileUtils.mv("#{@autoload_dir}#{@pathogen}", "#{@autoload_dir}#{@old}")
    download_pathogen
  else
    download_pathogen
  end
end

# Copy vim colorscheme to .vim/colors directory
def install_vim_theme
  @destination = File.expand_path("~/.vim/colors")
  if Dir.exists? @destination
    download_vim_theme
  else
    FileUtils.mkdir(@destination)
    download_vim_theme
  end
end

# Prep Vim-Ruby directories and install
# Rename any existing vim-ruby install to old
def install_vimruby
  @vimruby_dir = File.expand_path("~/.vim/bundle/vim-ruby")
  @old = File.expand_path("~/.vim/bundle/vim-ruby_old")
  if Dir.exists? @vimruby_dir
    FileUtils.mv(@vimruby_dir, @old)
    download_vimruby
  else
    download_vimruby
  end
end

# Copy .vimrc config to home directory
# Rename any existing config to old
def install_vimrc
  @source = ".vimrc"
  @old = ".vimrc_old"
  @destination = File.expand_path("~/")
  if File.file?("#{@destination}#{@source}")
    FileUtils.mv("#{@destination}#{@source}", "#{@destination}#{@old}")
    FileUtils.cp(@source, @destination)
  else
    FileUtils.cp(@source, @destination)
  end
end

# Copy .bash_profile to home directory
# Rename any existing config to old
def install_bash_profile
  @source = ".bash_profile"
  @old = ".bash_profile_old"
  @destination = File.expand_path("~/")
  if File.file?("#{@destination}#{@source}")
    FileUtils.mv("#{@destination}#{@source}", "#{@destination}#{@old}")
    FileUtils.cp(@source, @destination)
  else
    FileUtils.cp(@source, @destination)
  end
end

# Call installations
# Check operating system
if RUBY_PLATFORM.include?("linux")
  @os_version = "linux"
  puts "Linux OS detected - proceeding with install...".green
  download_bash_completion
  download_bash_prompt
  install_vimruby
  install_pathogen
  install_vim_theme
  install_vimrc
  install_bash_profile
  download_ohmyzsh
  install_ohmyzsh_theme
elsif RUBY_PLATFORM.include?("darwin")
  @os_version = "mac"
  puts "Mac OS detected - proceeding with install...".green
  download_bash_completion
  download_bash_prompt
  install_vimruby
  install_pathogen
  install_vim_theme
  install_vimrc
  install_bash_profile
  download_ohmyzsh
  install_ohmyzsh_theme
else
  puts "Operating System not supported!".red
  exit(1)
end
