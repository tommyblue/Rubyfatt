source 'https://rubygems.org'

gem 'rails', '3.2.8'

#----- SQLite or MySQL or..
#gem 'sqlite3'
gem 'mysql2'

#----- Authentication and authorization
gem 'devise'
gem 'cancan'

#----- PDF Generation
gem 'prawn',  '~> 1.0.0.rc1'

#----- Recurring invoices time management
gem 'ice_cube'
gem 'vpim'

#----- Forms made easy
gem 'simple_form'
gem 'country_select'

#----- Twitter bootstrap with SASS
gem 'bootstrap-sass', '~> 2.1.0.0'

#----- Paperclip
gem "paperclip", "~> 3.0"

#----- Exception notification
gem 'exception_notification'

group :development do
  gem "jeweler", "> 1.6.4"
  gem 'i18n-spec'
  gem 'localeapp'
end

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

# Use unicorn as the web server
gem 'unicorn'
