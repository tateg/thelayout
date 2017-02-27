# The Layout (thelayout.rb)
# This is a small utility for setting up the Bash and Vim environment
# Written by Tate Galbraith
# Feb 2017

# Check if git gem is installed and install if not found
begin
  gem "git"
rescue
  `gem install git`
end

# Require Git for cloning and FileUtils for copying
require 'git'
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

# Clone Vim colorschemes repo from GitHub
def clone_theme
  @repo = "https://github.com/flazz/vim-colorschemes"
  @name = "vim-colorschemes"
  if Dir.exists? @name
    FileUtils.rm_r(@name, :force => true)
  end
  Git.clone(@repo, @name)
end

# Copy .vimrc config to home directory
def install_vim_layout
  @source = ".vimrc"
  @destination = File.expand_path("~/")
  FileUtils.cp(@source, @destination)
end

# Copy colorschemes to .vim/colors directory
def install_vim_themes
  @source = "vim-colorschemes/colors/."
  @destination = File.expand_path("~/.vim/colors")
  if Dir.exists? @destination
    FileUtils.cp_r(@source, @destination)
  else
    FileUtils.mkdir(@destination)
    FileUtils.cp_r(@source, @destination)
  end
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
