require 'pry'
task :create do
  if ENV['name']
    puts "Include CMS gems? (y/n)"
    input = $stdin.gets.chomp
    if input == "y" || input == "Y" || input == "yes"
      puts "Including..."
    else
      puts "Skipping..."
    end
    puts ""

    puts "Include mail gems? (y/n)"
    input = $stdin.gets.chomp
    if input == "y" || input == "Y" || input == "yes"
      puts "Including..."
    else
      puts "Skipping..."
    end
    puts ""

    # puts `rails new ../#{ENV['name']} -m templates/template.rb --skip-gemfile --skip-test-unit -d mysql`
    # TODO: copy over rails root dir to project folder
    # puts `cp root/Gemfile ../#{ENV['name']}`
  else
    puts "You forgot to specify a rails project name:"
    puts "e.g. 'rake create name=sample-project'"
  end
end
