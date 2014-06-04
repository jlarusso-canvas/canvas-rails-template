require 'pry'
require 'fileutils'

task :new do

  # Make it look good
  # ---------------------------------------------------------------------------
  load 'support/colors.rb'
  load 'support/ascii.rb'
  puts Ascii::output


  # Reset
  # ---------------------------------------------------------------------------
  File.delete('root/Gemfile') if File.exist?('root/Gemfile')
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
  else
    puts "Skipping..."
  end
  puts ""


  # Create project
  # ---------------------------------------------------------------------------
  puts ""
  puts "-> Creating Rails app.".blue
  puts `rails new ../#{proj_name} --skip-gemfile --skip-test-unit -d mysql`
  puts `mv -v root/config/routes.rb ../#{proj_name}/config`


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

    # if cms
    puts `rails generate simple_form:install`
    puts `rails generate devise:install`
    puts `rails generate devise Administrator`
    puts `rake db:migrate`

    # if mail
  end


  # Overwrite with custom files
  # ---------------------------------------------------------------------------
  puts ""
  puts "-> Overwriting with custom files.".blue
  puts `cp -rv root/. ../#{proj_name}`
end
puts ""

