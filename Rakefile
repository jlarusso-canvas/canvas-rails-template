require 'pry'

task :new do
  puts "Enter Rails project name:"
  proj_name = $stdin.gets.strip
  puts ""

  # Reset
  File.delete('root/Gemfile') if File.exist?('root/Gemfile')
  `cp templates/Gemfile root/Gemfile`

  puts "Include CMS gems? (y/n)"
  input = $stdin.gets.strip
  if input == "y" || input == "yes"
    puts "Including..."
    `cat gem-groups/cms >> root/Gemfile`
  else
    puts "Skipping..."
  end
  puts ""

  puts "Include mail gems? (y/n)"
  input = $stdin.gets.strip
  if input == "y" || input == "yes"
    puts "Including..."
    `cat gem-groups/mail >> root/Gemfile`
  else
    puts "Skipping..."
  end
  puts ""

  # puts `rails new ../#{proj_name} -m templates/template.rb --skip-gemfile --skip-test-unit -d mysql`
  # TODO: copy over root dir to project folder
  # puts `cp root/Gemfile ../#{proj_name}`
end
