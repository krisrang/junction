source 'https://rubygems.org'
ruby "1.9.3"

gem 'rails', '~> 3.2.8'
gem 'puma'

# Persistence & caching
gem 'memcachier'
gem 'dalli'

# Frontend
gem 'jquery-rails'
gem 'twitter-bootstrap-rails'

# Misc frameworks, libs
gem 'rails_config'
gem 'airbrake'
gem 'oj'
gem 'twitter'
gem 'httparty'
gem 'octokit'
gem 'foursquare2'
gem 'rack-cache'
gem 'turbo-sprockets-rails3'

group :assets do
  gem 'execjs'
  gem 'therubyracer'
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'compass-rails'
  gem 'oily_png'
  gem 'asset_sync'
  gem 'js-routes'
end

group :development do
  gem 'terminal-notifier-guard'
end

group :test do
  gem 'simplecov', require: false
  gem 'faker'
end

group :test, :development do
  gem 'rb-fsevent'

  gem 'rspec-rails'
  gem 'cucumber-rails', require: false
  gem 'factory_girl_rails'

  gem 'poltergeist'
  gem 'database_cleaner'

  gem 'spork', '~> 1.0rc'
  gem 'spork-rails'
  gem 'guard-spork'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-cucumber'
end
