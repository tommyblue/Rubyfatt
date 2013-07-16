source 'https://rubygems.org'

gem 'rails', '4.0.0'

#----- Rails 3 compatibility (TO BE REMOVED ASAP)
gem 'protected_attributes'

#----- SQLite or MySQL or PostgreSQL or..
# gem 'sqlite3'
gem 'mysql2'
# gem 'pg'

#----- Authentication and authorization
gem 'devise', '~> 3.0.0'
gem 'cancan', '~> 1.6.10'

#----- PDF Generation
gem 'prawn',  '~> 1.0.0.rc1'

#----- Recurring invoices time management
gem 'ice_cube', '~> 0.11.0'

#----- Forms made easy
gem 'simple_form', '~> 3.0.0.rc'
gem 'country_select', '~> 1.2.0'

#----- Twitter bootstrap with SASS
gem 'bootstrap-sass', '~> 2.3.2.0'

#----- Paperclip
gem "paperclip", "~> 3.4.2"

#----- Exception notification
gem 'exception_notification', "~> 4.0.0"

group :development do
  gem 'better_errors', '~> 0.9.0'
  gem 'binding_of_caller'
  gem 'annotate'
  gem 'railroady'
  gem 'pry', '~> 0.9.12.2'
  gem 'therubyracer'
end

gem "rspec-rails", "~> 2.13.2", :group => [:test, :development]
group :test do
  gem "rake"
  gem "sqlite3"
  gem "mysql2"
  gem "pg", '~> 0.15.1'
  gem "factory_girl_rails", "~> 4.2.1"
  gem "capybara", '~> 2.1.0'
  gem "guard-rspec", "~> 3.0.2"
  gem 'rb-fsevent', '~> 0.9.1'
end

group :production do
  gem "airbrake_user_attributes", "~> 0.1.6"
end

#----- Assets
gem 'sass-rails',   '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '~> 2.1.2'

gem 'jquery-rails', '~> 3.0.4'
gem 'jquery-ui-rails', "~> 4.0.3"
gem 'select2-rails', '~> 3.4.3'
gem 'bootstrap-wysihtml5-rails'

# Use unicorn as the web server
gem 'unicorn', '~> 4.6.3'
