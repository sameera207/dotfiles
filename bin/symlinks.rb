# frozen_string_literal: true
#!/usr/bin/env ruby

require "fileutils"

%w(init.vim bash_profile bashrc tmux.conf zshrc gitconfig gitignore_global).each do |file|
  p "creating symlink for #{file}"
  `ln -s #{Dir.pwd}/#{file} ~/.#{file}` #FIXME: debug and start using File.symlink
end


