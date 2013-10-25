source 'http://rubygems.org'

ruby '2.1.0', engine: 'rbx', engine_version: '2.1.1'

gem 'rails', '4.0.1.rc2'

# Until it will be fixed by rails or rubinius
gem 'rubysl-openssl', require: false, github: 'miraks/rubysl-openssl', branch: '2.0'
gem 'rubysl-pathname', require: false, github: 'miraks/rubysl-pathname', branch: '2.0'
# Ruby standart library
gem 'rubysl', require: false
gem 'racc', require: false

# Server
gem 'puma'

# Database
gem 'pg'
gem 'redis'
gem 'dalli'

# Pagination
gem 'kaminari'

# Search
gem 'tire'

# Human-readable urls
gem 'friendly_id'
gem 'babosa'

# Auth
gem 'devise'

# Templates
gem 'slim'

# Files upload
gem 'carrierwave'

# Localization
gem 'russian'

# Jobs
gem 'resque'

# Configuration
gem 'custom_configuration'
gem 'dotenv-rails'

# JSON
gem 'rabl'
gem 'oj' # very fast json, very!

group :development do
  gem 'capistrano', require: false
  gem 'bullet'
  gem 'better_errors'
  gem 'awesome_print'
  gem 'pry-rails'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'timecop'
end

# Assets
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'
gem 'yui-compressor'
gem "compass-rails", "~> 2.0.alpha.0"