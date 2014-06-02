require 'fileutils'

# Create Gemfile
run "rm Gemfile"
run "cp ../canvas-rails-template/root/Gemfile ."
run "cp ../canvas-rails-template/root/.ruby-version ."

