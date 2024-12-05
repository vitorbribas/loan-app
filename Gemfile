# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.1.4'

gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'
gem 'jbuilder', '~> 2.10.0'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.3', '>= 7.1.3.4'
gem 'tzinfo-data', platforms: %i[windows jruby]

group :development, :test do
  gem 'byebug', '~> 11.1', '>= 11.1.3'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 3.1', '>= 3.1.1'
  gem 'rspec-rails', '~> 6.0', '>= 6.0.1'
  gem 'rubocop', '~> 1.49', require: false
  gem 'rubocop-rails', '~> 2.18', require: false
  gem 'rubocop-rspec', '~> 2.19', require: false
end

group :development do
  gem 'bullet', '~> 7.0', '>= 7.0.1'
  gem 'web-console'
end

group :test do
  gem 'database_cleaner', '~> 2.0', '>= 2.0.1'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', '~> 0.21.2', require: false
end
