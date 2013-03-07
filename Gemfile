source 'https://rubygems.org'

gem 'rails', '3.2.12'

#----- SQLite or MySQL or PostgreSQL or..
# gem 'sqlite3'
gem 'mysql2'
# gem 'pg'

#----- Authentication and authorization
gem 'devise', '~> 2.2.3'
gem 'cancan', '~> 1.6.8'

#----- PDF Generation
gem 'prawn',  '~> 1.0.0.rc1'

#----- Recurring invoices time management
gem 'ice_cube', '~> 0.9.3'
gem 'vpim', '~> 0.695'

#----- Forms made easy
gem 'simple_form', '~> 2.0.4'
gem 'country_select', '~> 1.1.3'

#----- Twitter bootstrap with SASS
gem 'bootstrap-sass', '~> 2.3.0.1'

#----- Paperclip
gem "paperclip", "~> 3.0"

#----- Exception notification
gem 'exception_notification'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'annotate'
  gem 'railroady'
  gem 'pry'
end

gem "rspec-rails", :group => [:test, :development]
group :test do
  gem "factory_girl_rails"
  gem "capybara"
  gem "guard-rspec"
  gem 'rb-fsevent', '~> 0.9.1'
end


# group :development do
#   gem "jeweler", "> 1.6.4"
#   gem 'i18n-spec'
#   gem 'localeapp'
# end

group :production do
  gem "airbrake_user_attributes"
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.5'
  gem 'coffee-rails', '~> 3.2.2'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'

# Use unicorn as the web server
gem 'unicorn'
