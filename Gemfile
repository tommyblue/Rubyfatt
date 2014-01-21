source 'https://rubygems.org'

ruby '2.1.0'

gem 'rails', '4.0.0'

#----- Rails 3 compatibility (TO BE REMOVED ASAP)
gem 'protected_attributes'

#----- SQLite or MySQL or PostgreSQL or..
# gem 'sqlite3'
gem 'mysql2', '~> 0.3.13'
gem 'pg', '~> 0.17.0'

#----- Authentication and authorization
gem 'devise', '~> 3.1.1'
gem 'cancan', '~> 1.6.10'

#----- PDF Generation
gem 'prawn',  '~> 1.0.0.rc1'

#----- Recurring invoices time management
gem 'ice_cube', '~> 0.11.0'

#----- Forms made easy
gem 'simple_form', '~> 3.0.0'
gem 'country_select', '~> 1.2.0'

#----- Twitter bootstrap with SASS
gem 'bootstrap-sass', '~> 2.3.2.2'

#----- Paperclip
gem "paperclip", "~> 3.5.1"

#----- Exception notification
gem 'exception_notification', "~> 4.0.1"

#----- Wiki
gem 'irwi', git: 'git://github.com/tommyblue/irwi.git', branch: 'rails4'

group :development do
  gem 'better_errors', '~> 1.0.1'
  gem 'binding_of_caller'
  gem 'annotate'
  gem 'railroady'
  gem 'pry', '~> 0.9.12.2'
  gem "brakeman", require: false
end

gem "rspec-rails", "~> 2.14.0", :group => [:test, :development]
group :test do
  gem "rake"
  gem "sqlite3", "~> 1.3.8"
  gem "factory_girl_rails", "~> 4.2.1"
  gem "capybara", '~> 2.1.0'
  gem "guard-rspec", "~> 3.1.0"
  gem 'rb-fsevent', '~> 0.9.1'
end

group :production do
  gem "airbrake_user_attributes", "~> 0.1.6"
end

#----- Assets
gem 'sass-rails',   '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '~> 2.2.1'
gem 'therubyracer', '~> 0.12.0'

gem 'jquery-rails', '~> 3.0.4'
gem 'jquery-ui-rails', "~> 4.0.5"
gem 'select2-rails', '~> 3.5.0'
gem 'bootstrap-wysihtml5-rails', '~> 0.3.1.23'

# Use unicorn as the web server
gem 'unicorn', '~> 4.6.3'
