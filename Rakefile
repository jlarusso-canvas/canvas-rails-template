task :create do
  if ENV['name']
    puts `rails new ../#{ENV['name']} -m template.rb --skip-gemfile --skip-test-unit -d mysql`
    # TODO: copy over rails root dir to project folder
  else
    puts "Enter a rails project name:"
    puts "e.g. 'rake create name=sample-project'"
  end
end
