source "https://rubygems.org"

ruby "3.2.2"

gem 'aws-sdk', require: false
gem "bootsnap", require: false
gem 'bullet', '~> 7.1', '>= 7.1.4'
gem 'devise', '~> 4.9', '>= 4.9.3'
gem 'friendly_id', '~> 5.4'
gem "image_processing", "~> 1.2"
gem "importmap-rails"
gem "jbuilder"
gem 'paper_trail', '~> 15.0'
gem "pg", "~> 1.1"
gem 'postmark'
gem 'postmark-rails'
gem "puma", ">= 5.0"
gem "rails", "~> 7.1.3"
gem "redis", ">= 4.0.1"
gem 'sidekiq', '~> 7.1.2'
gem 'sidekiq-cron', '~> 1.9.1'
gem "sprockets-rails"
gem "stimulus-rails"
gem "tailwindcss-rails", "~> 2.3"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem "byebug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rubocop-rails'
  gem 'dotenv-rails'
end

group :development do
  gem "web-console"
  gem "annotate"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end