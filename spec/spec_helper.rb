ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'uri'
require "paperclip/matchers"
require 'factory_girl_rails'


# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|

  config.include ActionDispatch::TestProcess

  config.include Paperclip::Shoulda::Matchers

  config.include FactoryGirl::Syntax::Methods

  config.include CapybaraHelpers

  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  Capybara.default_host = 'http://localhost:3000/'
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = {
  'info' => {
    'first_name' => 'Brent',
    'last_name' => 'Gaynor' },
  'uid' => '123545',
  'provider' => 'facebook',
  'credentials' => {'token' => 'token'}
}

  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end
