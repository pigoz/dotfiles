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
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end
end
