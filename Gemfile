source 'http://rubygems.org'

#ruby=2.1.0@box
ruby '2.1.0'

gem 'rails', '4.0.2'

# Server
gem 'puma'

# Database
gem 'pg'
gem 'redis'
gem 'dalli'
gem 'foreigner'

# Pagination
gem 'kaminari'

# Search
gem 'tire'

# Human-readable urls
gem 'friendly_id'
gem 'babosa'

# Authentication
gem 'devise'

# Authorization
# Until PRs 50 and 68 will be merged
gem 'pundit', github: 'miraks/pundit'

# Templates
gem 'slim'

# Files upload
gem 'carrierwave'

# Uploads processing
gem 'carrierwave_backgrounder'
gem 'carrierwave-processing'
gem 'mini_magick'
gem 'streamio-ffmpeg'

# Localization
gem 'russian'
gem 'devise-i18n'

# Jobs
gem 'sidekiq'
gem 'sinatra', require: false

# Configuration
gem 'custom_configuration'
gem 'dotenv-rails'

# JSON
gem 'active_model_serializers'
gem 'oj' # very fast json, very!

# Angular related
gem 'angularjs-rails-resource', '1.0.0.pre.1'

group :development do
  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'rvm1-capistrano3', require: false
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
gem 'turbolinks'
gem 'compass-rails'
