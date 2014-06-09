class Project
  load 'support/ascii.rb'
  attr_accessor :name, :gem_options, :ruby_version, :rails_version

  def initialize
    @ruby_version = '2.1.2'
    @rails_version = '4.1.1'
    @exe_new_flags = ['--skip-gemfile', '--skip-test-unit', '-d mysql', '2>&1']
    @gem_options = []
    @avail_gem_groups = Dir.entries('gem-groups').select { |f| !File.directory?(f) }
    puts Ascii::output
  end

  def ask_gem_group(group_name)
    if valid_gem_group?(group_name)
      print File.open("gem-groups/#{group_name}").read
      print "-> Include #{group_name} gems? (y/n) ".yellow
      input = $stdin.gets.strip

      if input == "y" || input == "yes"
        puts "Including..."
        `cat gem-groups/#{group_name} >> root/Gemfile`
        @gem_options << group_name
      else
        puts "Skipping..."
      end
      puts ""
    end
  end

  def exe_new(more_flags=[])
    flags = @exe_new_flags + more_flags
    cmd = "rails _#{rails_version}_ new ../#{name} #{flags.join(' ')}"
    puts cmd.blue
    `#{cmd}`
  end

  def exe_in_root(&block)
    Dir.chdir("../#{name}") do
      instance_eval(&block)
    end
  end

  def self.run(str)
    puts ""
    puts str.blue
    puts `#{str}`
  end

  def self.alert(str)
    puts ""
    puts ""
    puts str.yellow
  end

  def self.append(text, path)
    puts ""
    cmd = "echo '#{text}' >> #{path}"
    puts cmd.blue
    `#{cmd}`
  end

  def self.gsub_text(path, old, new)
    puts ""
    puts "gsub #{path}".blue
    puts "Old:\n----\n#{old}\n\nNew:\n----\n#{new}"
    file = File.read(path)
    File.open(path, "w") { |f| f.puts file.gsub(old, new) }
  end

  private

  def valid_gem_group?(group_name)
    @avail_gem_groups.include?(group_name)
  end
end
