require 'coveralls'
Coveralls.wear!

ENV['RACK_ENV'] ||= 'test'

require 'sinatra/auth/github'
require 'sinatra/auth/github/test/test_helper'
require 'capybara/rspec'
require 'webmock/rspec'

require File.expand_path '../../lib/github_issues_exporter/web.rb', __FILE__

Dir["./spec/support/**/*.rb"].sort.each { |f| require f}

RSpec.configure do |config|
  config.include(Rack::Test::Methods)
  config.include(Sinatra::Auth::Github::Test::Helper)

  def app
    GithubIssuesExporter::Web
  end

  Capybara.app = app
end
