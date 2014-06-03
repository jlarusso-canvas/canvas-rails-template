require 'pry'


task :new do

  load 'support/colors.rb'
  load 'support/ascii.rb'

  puts Ascii::output


  # Get rails project string
  puts "Enter Rails project name:"
  proj_name = $stdin.gets.strip
  puts ""

  # Reset
  File.delete('root/Gemfile') if File.exist?('root/Gemfile')
  `cp templates/Gemfile root/Gemfile`

  # Gem options
  puts "Include CMS gems? (y/n)"
  input = $stdin.gets.strip
  if input == "y" || input == "yes"
    puts "Including...".green
    `cat gem-groups/cms >> root/Gemfile`
  else
    puts "Skipping...".yellow
  end
  puts ""

  puts "Include mail gems? (y/n)"
  input = $stdin.gets.strip
  if input == "y" || input == "yes"
    puts "Including...".green
    `cat gem-groups/mail >> root/Gemfile`
  else
    puts "Skipping...".yellow
  end
  puts ""

  # Create project
  # puts `rails new ../#{proj_name} -m templates/template.rb --skip-gemfile --skip-test-unit -d mysql`
  # TODO: copy over root dir to project folder

  # Overwrite with custom files
  # puts `cp root/Gemfile ../#{proj_name}`
end
