require 'rake'

def update_vim_plugins(checkout_master=nil)
  dotfiles_dir = Dir.getwd
  bundle_dir = "#{dotfiles_dir}/vim/vim.symlink/bundle"
  Dir.chdir(bundle_dir)
  bundles = Dir.glob("*")
  bundles.each do |bundle|
    if File.directory?(bundle)
      Dir.chdir(bundle)
      if checkout_master
        `git checkout --quiet master`
      else
        puts "Updating vim plugin: #{bundle}"
        `git checkout --quiet master && git pull`
      end
      Dir.chdir(bundle_dir)
    end
  end
  Dir.chdir(dotfiles_dir)
end

namespace :vim do
  desc "Update Vim plugins"
  task :update do
    dotfiles_dir = Dir.getwd
    vim_dir = "#{dotfiles_dir}/vim/vim.symlink"

    Dir.chdir(vim_dir)
    `git submodule update --init --recursive`

    Dir.chdir(dotfiles_dir)
    update_vim_plugins

    Dir.chdir("#{vim_dir}/bundle/cmd-T/ruby/command-T") do
      if File.exists?("/usr/bin/ruby1.8") # prefer 1.8 on *.deb systems
        sh "/usr/bin/ruby1.8 extconf.rb"
      elsif File.exists?("/usr/bin/ruby") # prefer system rubies
        sh "/usr/bin/ruby extconf.rb"
      elsif `rvm > /dev/null 2>&1` && $?.exitstatus == 0
        sh "rvm system ruby extconf.rb"
      end
      sh "make clean && make"
    end
  end
end

desc "Hook our dotfiles into system-standard positions."
task :install do
  linkables = Dir.glob('*/**{.symlink}')

  overwrite_all = false
  backup_all = false
  skip_all = false

  linkables.each do |linkable|
    overwrite = false
    backup = false
    skip = false

    file = linkable.split('/').last.split('.symlink')
    target = "#{ENV["HOME"]}/.#{file}"

    if File.exists?(target) || File.symlink?(target)
      unless skip_all || overwrite_all || backup_all
        puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.gets.chomp
        when 'o' then overwrite = true
        when 'b' then backup = true
        when 's' then skip = true
        when 'O' then overwrite_all = true
        when 'B' then backup_all = true
        when 'S' then skip_all = true
        end
      end
      FileUtils.rm_rf(target) if overwrite || overwrite_all
      `mv "$HOME/.#{file}" "$HOME/.#{file}.backup"` if backup || backup_all
    end
    `ln -s "$PWD/#{linkable}" "#{target}"` unless skip || skip_all
  end

  unless skip_all
    `git submodule update --quiet --init --recursive`
    update_vim_plugins(true)
  end
end
task :default => 'install'
