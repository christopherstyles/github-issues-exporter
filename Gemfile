source 'https://rubygems.org'

ruby '2.1.2'

gem 'rake'
gem 'newrelic_rpm'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-rspec'
  gem 'pry'
end

group :test do
  gem 'capybara'
  gem 'coveralls', require: false
  gem 'rb-fsevent', '~> 0.9'
  gem 'webmock', '>= 1.9'
end

group :development, :test do
  gem 'rspec', '>= 3.0'
end

gemspec
