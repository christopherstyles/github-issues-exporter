require 'dotenv'
require 'octokit'
require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/partial'
require 'slim'
require 'verbs'

require 'github_issues_exporter/web_helpers'
require 'github_api'

Dotenv.load

module GithubIssuesExporter
  # :nodoc:
  class Web < Sinatra::Base
    include WebHelpers

    configure do
      register Sinatra::Partial
      set :root, File.expand_path(File.dirname(__FILE__) + '/../../web')
      set :public_folder, proc { "#{root}/assets" }
      set :views, proc { "#{root}/views" }
      set :slim, pretty: false, format: :html5
      set :partial_template_engine, :slim
    end

    configure :development do
      register Sinatra::Reloader
    end

    get '/' do
      slim :dashboard
    end
  end
end
