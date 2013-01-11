source 'https://rubygems.org'
ruby "1.9.3"

gem 'rails', '~> 3.2.11'
gem 'capistrano'
gem 'foreman'
gem 'puma'
gem 'meow-logger'

# Persistence & caching
gem 'memcachier'
gem 'dalli'
gem 'mongoid'

# Frontend
gem 'twitter-bootstrap-rails'

# Misc frameworks, libs
gem 'rails_config'
gem 'airbrake'
gem 'oj'
gem 'twitter'
gem 'twitter-text'
gem 'httparty'
gem 'octokit'
gem 'foursquare2'
gem 'whenever', require: false

# Mailer
gem 'premailer-rails3'
gem 'hpricot'
gem 'mail_view'
gem 'action_mailer_cache_delivery'

group :assets do
  gem 'execjs'
  gem "therubyracer", "0.10.2"
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  gem 'compass-rails'
  gem 'oily_png'
  # gem 'asset_sync'
  gem 'js-routes'
  gem 'jquery-rails'
  gem 'less-rails'
  gem 'turbo-sprockets-rails3'
end

group :development do
  gem 'pry'
  gem 'terminal-notifier-guard'
  gem 'meow-deploy', require: false
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
  gem 'mongoid-rspec'

  gem 'poltergeist'
  gem 'database_cleaner'

  gem 'spork', '~> 1.0rc'
  gem 'spork-rails'
  gem 'guard-spork'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-cucumber'
end
