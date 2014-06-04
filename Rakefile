require 'pry'
# require 'fileutils'

task :new do

  # Make it look good
  # ---------------------------------------------------------------------------
  load 'support/colors.rb'
  load 'support/ascii.rb'
  puts Ascii::output


  # Reset
  # ---------------------------------------------------------------------------
  gem_options = []
  `cp templates/Gemfile root/Gemfile`


  # Get rails project name
  # ---------------------------------------------------------------------------
  puts "-> Enter Rails project name:".blue
  proj_name = $stdin.gets.strip
  puts ""


  # Gem options
  # ---------------------------------------------------------------------------
  print File.open('gem-groups/cms').read
  print "-> Include CMS gems? (y/n) ".blue
  input = $stdin.gets.strip
  if input == "y" || input == "yes"
    puts "Including..."
    `cat gem-groups/cms >> root/Gemfile`
    gem_options << 'cms'
  else
    puts "Skipping..."
  end
  puts ""

  print File.open('gem-groups/mail').read
  print "-> Include mail gems? (y/n) ".blue
  input = $stdin.gets.strip
  if input == "y" || input == "yes"
    puts "Including..."
    `cat gem-groups/mail >> root/Gemfile`
    gem_options << 'mail'
  else
    puts "Skipping..."
  end
  puts ""


  # Create project
  # ---------------------------------------------------------------------------
  puts ""
  puts "-> Creating Rails app.".blue
  puts `rails new ../#{proj_name} --skip-gemfile --skip-test-unit -d mysql`


  # Copy Gemfile and 'bundle install'
  # ---------------------------------------------------------------------------
  puts ""
  puts "-> Installing gems; this may take a minute or two.".blue
  puts `mv -v root/Gemfile ../#{proj_name}`
  Dir.chdir("../#{proj_name}") do
    puts `bundle install`
  end


  # Run installers and generators
  # ---------------------------------------------------------------------------
  puts ""
  puts "-> Running installers and generators.".blue
  Dir.chdir("../#{proj_name}") do
    puts `rails generate cucumber:install`
    puts `guard init rspec`
    puts `guard init cucumber`
    puts `rails generate dragonfly`

    if gem_options.include? 'cms'
      puts `rails generate simple_form:install`
      puts `rails generate devise:install`
      puts `rails generate devise Administrator`
    end

    if gem_options.include? 'mail'
    end
  end


  # Overwrite with custom files
  # ---------------------------------------------------------------------------
  puts ""
  puts "-> Overwriting with custom files.".blue
  puts `cp -rv root/. ../#{proj_name}`


  # Database stuff
  # ---------------------------------------------------------------------------
  puts ""
  Dir.chdir("../#{proj_name}") do
    db_config = File.read('config/database.yml')
    old = "default: &default\n  adapter: mysql2\n  encoding: utf8\n  pool: 5\n  username: root\n  password:"
    new = "default: &default\n  adapter: mysql2\n  encoding: utf8\n  pool: 5\n  username: root\n  password: pw"
    replace = db_config.gsub(old, new)
    File.open("config/database.yml", "w") { |file| file.puts replace }

    puts `rake db:create`
    puts `rake db:migrate`
  end
end
puts ""

