source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use pg as the database for production

group :heroku do
#  gem 'pg'
  gem 'rails_12factor'
end

group :production do
  gem 'mysql2'
end


gem 'exceptiontrap'
gem 'thin'
gem 'unique_generator'
gem 'paperclip', '~> 3.0'
gem 'aws-sdk'
gem 'omniauth-facebook'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'faker'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails', "~> 4.0"
  gem 'pry'
  gem 'shoulda-matchers'
  gem 'dotenv-rails'
  gem 'selenium-webdriver'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development