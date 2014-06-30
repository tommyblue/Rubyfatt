require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'coveralls'
Coveralls.wear!

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'pundit/rspec'

load_schema = lambda {
  load "#{Rails.root.to_s}/db/schema.rb" # use db agnostic schema by default
  # ActiveRecord::Migrator.up('db/migrate') # use migrations
}
silence_stream(STDOUT, &load_schema)

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  config.include Devise::TestHelpers, type: :controller
  config.extend ControllerMacros, type: :controller
  config.include ValidUserRequestHelper, type: :request

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

def generate_scenario
  @user1 = FactoryGirl.create :user
  @consolidated_tax = FactoryGirl.create :consolidated_tax
  @tax1 = FactoryGirl.create :tax, order: 0, name: 'INPS 4%', rate: 4, compound: false, consolidated_tax: @consolidated_tax
  @tax2 = FactoryGirl.create :tax, order: 1, name: 'IVA 21%', rate: 21, compound: true, consolidated_tax: @consolidated_tax
  @tax3 = FactoryGirl.create :tax, order: 2, name: "Ritenuta d'acconto -20%", rate: -20, compound: true, consolidated_tax: @consolidated_tax

  @customer1 = FactoryGirl.create :customer, user: @user1
  @slip1 = FactoryGirl.create :slip, customer: @customer1
  @slip2 = FactoryGirl.create :slip, customer: @customer1

  @customer2 = FactoryGirl.create :customer, user: @user1
  @slip3 = FactoryGirl.create :slip, customer: @customer2
  @slip4 = FactoryGirl.create :slip, customer: @customer2
  @slip5 = FactoryGirl.create :slip, customer: @customer2

  @user2 = FactoryGirl.create :user
  @customer3 = FactoryGirl.create :customer, user: @user2

  # Grant API access
  @user1.tokens.create
  @user2.tokens.create
end
