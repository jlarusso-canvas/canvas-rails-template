require 'pry'
load 'support/project.rb'

task :new do
  # Don't buffer output- flush immediately
  $stdout.sync = true

  # Make it look good
  # ---------------------------------------------------------------------------
  load 'support/colors.rb'


  # Reset
  # ---------------------------------------------------------------------------
  proj = Project.new # => See Project class for defaults
  Project.alert "-> Checking Ruby version."
  Project.run "rvm install #{proj.ruby_version}"
  Project.run "cp -v templates/Gemfile root/Gemfile"


  # Get rails project name
  # ---------------------------------------------------------------------------
  Project.alert "-> Enter Rails project name:"
  proj.name = $stdin.gets.strip


  # Gem options
  # ---------------------------------------------------------------------------
  proj.ask_gem_group('cms')
  proj.ask_gem_group('mail')


  # Create project
  # ---------------------------------------------------------------------------
  Project.alert "-> Creating Rails app."
  exe_new_output = proj.exe_new
  if exe_new_output.match(/Gem::LoadError/)
    Project.alert "-> Installing Rails #{proj.rails_version}."
    Project.run "gem install rails --version=#{proj.rails_version}"
    puts proj.exe_new
  else
    puts exe_new_output
  end


  # Copy Gemfile and 'bundle install'
  # ---------------------------------------------------------------------------
  Project.run "mv -v root/Gemfile ../#{proj.name}"
  Project.alert "-> Installing gems; this may take a while. Grab a sandwich and come back in a few minutes."
  proj.exe_in_root do
    Project.run "bundle install"
  end


  # Run installers and generators
  # ---------------------------------------------------------------------------
  Project.alert "-> Running installers and generators."
  proj.exe_in_root do
    Project.run "rails generate cucumber:install"
    Project.run "guard init rspec"
    Project.run "guard init cucumber"
    Project.run "rails generate dragonfly"

    if gem_options.include? 'cms'
      Project.run "rails generate simple_form:install"
      Project.run "rails generate devise:install"
      Project.run "rails generate devise Administrator"
    end

    if gem_options.include? 'mail'
      # TODO: run mail generators and installers
    end
  end


  # Overwrite with custom files
  # ---------------------------------------------------------------------------
  Project.alert "-> Overwriting with custom files."
  Project.run "cp -rv root/* ../#{proj.name}"
  Project.run "cp -rv admin/* ../#{proj.name}" if gem_options.include? 'cms'
  Project.append("World(FactoryGirl::Syntax::Methods)", "../#{proj.name}/features/support/env.rb")


  # Database stuff
  # ---------------------------------------------------------------------------
  proj.exe_in_root do
    db_config = File.read('config/database.yml')
    old = "default: &default\n  adapter: mysql2\n  encoding: utf8\n  pool: 5\n  username: root\n  password:"
    new = "default: &default\n  adapter: mysql2\n  encoding: utf8\n  pool: 5\n  username: root\n  password: pw"
    replace = db_config.gsub(old, new)
    File.open("config/database.yml", "w") { |file| file.puts replace }

    Project.run "rake db:create"
    Project.run "rake db:migrate"
  end


  # Cleanup
  # ---------------------------------------------------------------------------
  Project.alert "-> Cleaning up."
  proj.exe_in_root do
    Project.run "rm app/assets/stylesheets/application.css"
    Project.run "rm app/views/layouts/application.html.erb"
    Project.run "rm README.rdoc"
  end


  puts "Success! Your new Rails project is installed in '../#{proj.name}'".green
  puts ""
end

