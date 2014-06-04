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
  puts "-> Creating Rails app".blue
  puts `rails new ../#{proj_name} -m templates/template.rb --skip-gemfile --skip-test-unit -d mysql`


  # Overwrite with custom files
  # ---------------------------------------------------------------------------
  puts ""
  puts "-> Overwriting with custom files".blue
  puts `cp -rv root/. ../#{proj_name}`

  puts ""
  puts "-> Installing gems, please wait".blue
  Dir.chdir("../#{proj_name}") do
    puts `bundle install`
  end
  puts ""
end
