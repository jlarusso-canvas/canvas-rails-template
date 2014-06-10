load 'support/project.rb'

task :default do
  # Don't buffer output- flush immediately
  $stdout.sync = true

  # Make it look good
  # ---------------------------------------------------------------------------
  load 'support/colors.rb'


  # Reset
  # ---------------------------------------------------------------------------
  proj = Project.new # => See Project class for defaults
  Project.alert "### Setting up your environment (this may take some time) ###"
  puts "Ruby: #{proj.ruby_version}"
  puts "Rails: #{proj.rails_version}"
  Project.alert "-> Checking Ruby version."
  Project.run "rvm install #{proj.ruby_version}"
  Project.run "rvm use #{proj.ruby_version}"
  Project.run "cp -v templates/Gemfile rails_root_dirs/default/Gemfile"


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
  Project.run "mv -v rails_root_dirs/default/Gemfile ../#{proj.name}"

  unless proj.gem_options.include?('mail') && proj.gem_options.include?('cms')
    Project.gsub_text("../#{proj.name}/Gemfile",
                      "gem 'devise-async'",
                      "# gem 'devise-async'"
                     )
  end

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
      Project.run "rails generate simple_form:install --bootstrap"
      Project.run "rails generate devise:install"
      Project.run "rails generate devise Administrator"
      Project.run "rails generate devise:views administrators"
    end

    if gem_options.include? 'mail'
      # Put mail generators here if needed.
    end
  end


  # Overwrite with custom files
  # ---------------------------------------------------------------------------
  Project.alert "-> Overwriting with custom files."
  Project.run "cp -rv rails_root_dirs/default/* ../#{proj.name}"

  if proj.gem_options.include? 'cms'
    Project.run "cp -rv rails_root_dirs/admin/* ../#{proj.name}"
  end

  Project.append("World(FactoryGirl::Syntax::Methods)", "../#{proj.name}/features/support/env.rb")


  # Database stuff
  # ---------------------------------------------------------------------------
  proj.exe_in_root do
    Project.gsub_text("config/database.yml",
                      "default: &default\n  adapter: mysql2\n  encoding: utf8\n  pool: 5\n  username: root\n  password:",
                      "default: &default\n  adapter: mysql2\n  encoding: utf8\n  pool: 5\n  username: root\n  password: pw"
                     )
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
    Project.gsub_text("config/environments/production.rb",
                      "Rails.application.configure do\n",
                      "Rails.application.configure do\n  config.cache_store = :dalli_store\n"
                     )

    if gem_options.include? 'mail'
      Project.gsub_text("config/environments/development.rb",
                        "Rails.application.configure do\n  # Settings specified here will take precedence over those in config/application.rb.\n\n",
                        "Rails.application.configure do\n  # Settings specified here will take precedence over those in config/application.rb.\n\n  config.action_mailer.delivery_method = :letter_opener\n\n"
                       )
      Project.gsub_text("config/environments/development.rb",
                        "config.action_mailer.raise_delivery_errors = false",
                        "config.action_mailer.default_url_options = { host: 'localhost:3000' }\n  config.action_mailer.raise_delivery_errors = false"
                       )
      Project.gsub_text("features/support/env.rb",
                        "require 'cucumber/rails'\n",
                        "require 'cucumber/rails'\nrequire 'email_spec/cucumber'\n"
                       )
      Project.gsub_text("spec/rails_helper.rb",
                        "require 'rspec/rails'\n",
                        "require 'rspec/rails'\nrequire 'email_spec'\n"
                       )
      Project.gsub_text("spec/rails_helper.rb",
                        "RSpec.configure do |config|\n  ",
                        "RSpec.configure do |config|\n  config.include(EmailSpec::Helpers)\n  config.include(EmailSpec::Matchers)\n  "
                       )
    end

    if gem_options.include? 'cms'
      Project.gsub_text("config/initializers/devise.rb",
                        "# config.scoped_views = false",
                        "config.scoped_views = true"
                       )
    end
  end


  puts "Success! Your new Rails project is installed in '../#{proj.name}'".green
  puts ""
end

