class Project
  load 'support/ascii.rb'
  attr_accessor :name, :gem_options

  def initialize
    @gem_options = []
    @avail_gem_groups = Dir.entries('gem-groups').select { |f| !File.directory?(f) }
    puts Ascii::output
  end

  def ask_gem_group(group_name)
    if valid_gem_group?(group_name)
      print File.open("gem-groups/#{group_name}").read
      print "-> Include #{group_name} gems? (y/n) ".blue
      input = $stdin.gets.strip

      if input == "y" || input == "yes"
        puts "Including..."
        `cat gem-groups/#{group_name} >> root/Gemfile`
        @gem_options << 'cms'
      else
        puts "Skipping..."
      end
      puts ""
    end
  end

  def exe_in_root(&block)
    Dir.chdir("../#{self.name}") do
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

  private

  def valid_gem_group?(group_name)
    @avail_gem_groups.include?(group_name)
  end
end
