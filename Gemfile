source 'https://rubygems.org'

ruby '2.1.2'

gem 'dotenv'
gem 'newrelic_rpm'
gem 'octokit'
gem 'rake'
gem 'sinatra'
gem 'sinatra_auth_github'
gem 'sinatra-contrib'
gem 'sinatra-partial'
gem 'slim'
gem 'thin'

group :test, :development do
  gem 'rspec', '>= 3.0'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-rspec'
  gem 'pry'
end

group :test do
  gem 'capybara'
  gem 'coveralls', require: false
  gem 'rack-test'
  gem 'rb-fsevent', '~> 0.9'
  gem 'webmock', '>= 1.9'
end

gemspec
