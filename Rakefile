require 'rake'
require 'erb'

desc "install the dot files into user's home directory"
task :install do
  replace_all = false
  Dir['*'].each do |file|
    next if no_copy_files_list.include? file
    if File.exist?(full_dest(file))
      if File.identical? file, full_dest(file)
        puts "identical ~/.#{dest(file)}"
      elsif replace_all
        replace_file(file)
      else
        print "overwrite ~/.#{dest(file)}? [ynaq] "
        case $stdin.gets.chomp
        when 'a'
          replace_all = true
          replace_file(file)
        when 'y'
          replace_file(file)
        when 'q'
          exit
        else
          puts "skipping ~/.#{dest(file)}"
        end
      end
    else
      link_file(file)
    end
  end
end

desc "make iTerm2 load and save its settings in config/iterm2"
task :iterm do
  # iTerm2 writes its in-memory settings back on quit, overwriting these
  if `ps -axo comm=`.lines.any? { |l| l.chomp.end_with?('/MacOS/iTerm2') }
    abort "quit iTerm2 and run `rake iterm` from Terminal.app"
  end
  domain = 'com.googlecode.iterm2'
  system 'defaults', 'write', domain, 'PrefsCustomFolder', '-string', File.expand_path('config/iterm2')
  system 'defaults', 'write', domain, 'LoadPrefsFromCustomFolder', '-bool', 'true'
  # "Save changes: Automatically"
  system 'defaults', 'write', domain, 'NoSyncNeverRemindPrefsChangesLostForFile', '-bool', 'true'
  system 'defaults', 'write', domain, 'NoSyncNeverRemindPrefsChangesLostForFile_selection', '-int', '2'
  puts "iTerm2 settings: #{File.expand_path('config/iterm2')}"
end

task :default => [:install, :iterm]

def no_copy_files_list
  %w[Rakefile README.md LICENSE]
end

def replace_file(file)
  system %Q{rm -rf "$HOME/.#{dest(file)}"}
  link_file(file)
end

def dest(name)
  name.sub('.erb', '')
end

def full_dest(file)
  File.join(ENV['HOME'], ".#{dest(file)}")
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub('.erb', '')}"
    File.open(full_dest(file), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/.#{file}"
    system %Q{ln -fs "$PWD/#{file}" "$HOME/.#{file}"}
  end
end
