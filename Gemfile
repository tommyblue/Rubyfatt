source 'https://rubygems.org'
ruby '2.1.1'

gem 'rails', '4.0.3'

#----- Databases
gem 'mysql2', '~> 0.3.13'

#----- Authentication and authorization
gem 'devise', '~> 3.2.3'
gem 'pundit', '~> 0.2.2'

#----- PDF Generation
gem 'prawn',  '~> 1.0.0.rc2'

#----- Recurring invoices time management
gem 'ice_cube', '~> 0.11.3'

#----- Forms made easy
# gem 'simple_form', '~> 3.0.1'
# gem 'country_select', '~> 1.3.1'

#----- Paperclip
gem 'paperclip', '~> 4.1.1'

#----- Exception notification
gem 'exception_notification', '~> 4.0.1'

#----- Wiki
gem 'irwi', git: 'git://github.com/tommyblue/irwi.git', branch: 'rails4'

#----- API
gem 'active_model_serializers', '~> 0.8.1'

group :development do
  gem 'better_errors', '~> 1.1.0'
  # Brakeman detects security vulnerabilities in Ruby on Rails applications via static analysis.
  # gem 'brakeman', '~> 2.4.1', require: false
end
gem 'pry-rails', '~> 0.3.2', group: [:test, :development]

# gem 'rspec-rails', '~> 3.0.0.beta', group: [:test, :development]
gem 'rspec-rails', '~> 2.14.1', group: [:test, :development]
group :test do
  gem 'rake', '~> 10.1.0'
  gem 'sqlite3', '~> 1.3.9'
  gem 'pg', '~> 0.17.1'
  gem 'factory_girl_rails', '~> 4.4.1'
  # gem 'capybara', '~> 2.2.1'
  gem 'guard-rspec', '~> 4.2.8', require: false # incompatible with rspec-rails 3.0.0.beta
  gem 'growl'
  gem 'rb-fsevent', '~> 0.9.4'
end

group :production do
  gem 'airbrake_user_attributes', '~> 0.1.6'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.4.0', require: false
end

#----- Assets
gem 'sass-rails',   '~> 4.0.1'
gem 'coffee-rails', '~> 4.0.1'
gem 'uglifier', '~> 2.4.0'
gem 'therubyracer', '~> 0.12.1', platform: :ruby

#----- ZURB Foundation
gem 'foundation-rails'

#----- Ember.js
gem 'ember-rails', '~> 0.14.1'
gem 'ember-source', '~> 1.4.0'

gem 'jquery-rails', '~> 3.1.0'
# gem 'jquery-ui-rails', '~> 4.2.0'

# Use unicorn as the web server
gem 'unicorn', '~> 4.8.2'
# gem 'capistrano', '~> 3.1.0'
