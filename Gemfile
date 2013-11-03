source 'http://rubygems.org'

ruby '2.1.0', engine: 'rbx', engine_version: '2.1.1'

gem 'rails', '4.0.1'

# Until it will be fixed by rails or rubinius
gem 'rubysl-openssl', require: false, github: 'miraks/rubysl-openssl', branch: '2.0'
gem 'rubysl-pathname', require: false, github: 'miraks/rubysl-pathname', branch: '2.0'
gem 'rubysl-singleton', require: false, github: 'miraks/rubysl-singleton', branch: '2.0'
# Ruby standart library
gem 'rubysl', require: false
gem 'racc', require: false

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

# Auth
gem 'devise'

# Templates
gem 'slim'

# Files upload
gem 'carrierwave'

# Localization
gem 'russian'
gem 'devise-i18n'

# Jobs
gem 'sidekiq'

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
gem 'compass-rails', '~> 2.0.alpha.0'