ruby '2.1.5'

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.7'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.17.1'
gem 'pg_search', '~> 0.7.8'

# Pagination
gem 'will_paginate', '~> 3.0.7'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring', group: :development

# Pry for rails console
gem 'pry-rails', group: :development

# for travis
gem 'rake', group: :test

# for console, rake
gem 'highline'

# .Env gem Gem
gem 'dotenv-rails'

# Rubocop for testing
gem 'rubocop', group: [:development, :test]

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7', require: 'bcrypt'

# Use unicorn as the app server
# gem 'unicorn'

# Use puma as the app server
gem 'puma'

# Use web-console
gem 'web-console', '~> 2.0.0', group: :development

# Use responders
gem 'responders'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Authentication
gem 'devise'
gem 'ruby-saml'

# Authorization
gem 'pundit'

# Tests
group :development, :test do
  gem 'factory_girl_rails', '~> 4.0'
  gem 'rspec-rails', '~> 3.0'
  gem 'database_cleaner', '~> 1.3.0'
  gem 'brakeman', require: false
  gem 'license_finder'
  gem 'codeclimate-test-reporter', require: nil
  gem 'seed_dump'
  gem 'annotate' # Improves your sanity by annotating models
end

# Documentation
gem 'apipie-rails', '~> 0.2.6'

# Keep but hide deleted records
gem 'paranoia'

# Communicating with external services
gem 'rest-client'
gem 'virtus'

# CORS
gem 'rack-cors'

# CSRF
gem 'angular_rails_csrf', '~> 1.0.3' # XSRF-TOKEN is added to the cookie by default.

# CRONTAB SCHEDULER
gem 'whenever'

# ActiveRecord DelayedJob
gem 'delayed_job_active_record'

# Daemons for DelayedJob
gem 'daemons'

# Get picky about what is put into responses
gem 'active_model_serializers', '~> 0.8.0'
