# Create an app with this template using:
# => rails new app_name -J -T -m template_name.rb

# Insert some default gems into the Gemfile.
gem "rspec-rails", ">= 2.1.0", :group => [:development, :test]
gem "annotate-models", '1.0.4'
#gem "factory_girl_rails", ">= 1.0.0", :group => :test
#gem "factory_girl_generator", ">= 0.0.1", :group => [:development, :test]

# Setup RSpec Generators
generators = <<-GENERATORS

    config.generators do |g|
      g.test_framework :rspec, :fixture => true, :views => false
      g.integration_tool :rspec, :fixture => true, :views => true
    end
GENERATORS
application generators

# Get JQuery and JQuery Adapter for Rails UJS
get "http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js",  "public/javascripts/jquery.js"
get "http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.5/jquery-ui.min.js", "public/javascripts/jquery-ui.js"
run "curl -L http://github.com/rails/jquery-ujs/raw/master/src/rails.js > public/javascripts/rails.js"

# Include JQuery and UJS adapter in javascript ":defaults"
gsub_file 'config/application.rb', 'config.action_view.javascript_expansions[:defaults] = %w()', 'config.action_view.javascript_expansions[:defaults] = %w(jquery.js jquery-ui.js rails.js)'

# Setup Git and Initialize a repository.
create_file "log/.gitkeep"
create_file "tmp/.gitkeep"
git :init
git :add => "."

# Display a helpful setup message.
docs = <<-DOCS
Run the following commands to complete the setup of #{app_name.humanize}:

% cd #{app_name}
% bundle install
% rails g rspec:install
% rake db:create:all

For blueprint css:
% cp -rf path_to_template/blueprint_1.0 public/stylesheets/blueprint

For useful command cheatsheet:
% cp path_to_template/mc_rails_commmands.txt ./

DOCS
log docs
