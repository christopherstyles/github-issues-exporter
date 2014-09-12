require 'csv'
require 'dotenv'
require 'octokit'
require 'sinatra/auth/github'
require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/partial'
require 'slim'
require 'newrelic_rpm'

require 'github_issues_exporter/web_helpers'

Dotenv.load

module GithubIssuesExporter
  # :nodoc:
  class Web < Sinatra::Base
    include WebHelpers

    helpers do
      def repos
        @repos ||= github_user.api.repositories(type: 'all')
      end

      def orgs
        @orgs ||= github_user.api.organizations
      end

      def issues
        return [] unless params[:repo]
        @issues ||= github_user.api.list_issues(params[:repo], issue_filters)
      end

      def milestones
        return [] unless params[:repo]
        @milestones ||= github_user.api.list_milestones(params[:repo])
      end

      def repository_name
        [params[:org], params[:repo]].reject { |name| name == '' }.compact.join('/')
      end

      def issue_filters
        filters = {
          state: params[:state],
          per_page: 100,
          sort: params[:sort]
        }

        if params[:milestone] && params[:milestone] != '*'
          filters.merge!(milestone: params[:milestone])
        end

        filters
      end
    end

    configure :development do
      require 'better_errors'

      use BetterErrors::Middleware
      BetterErrors.application_root = __dir__
    end

    configure do
      enable :sessions

      register Sinatra::Partial
      register Sinatra::Auth::Github

      set :root, File.expand_path(File.dirname(__FILE__) + '/../../web')
      set :public_folder, proc { "#{root}/assets" }
      set :views, proc { "#{root}/views" }
      set :slim, pretty: false, format: :html5
      set :partial_template_engine, :slim
      set :github_options, {
        scopes:    'user,repo,read:org',
        secret:    ENV['GITHUB_CLIENT_SECRET'],
        client_id: ENV['GITHUB_CLIENT_ID'],
      }
    end

    configure :development do
      register Sinatra::Reloader
    end

    get '/' do
      @github_user = nil
      slim :index
    end

    get '/dashboard' do
      authenticate!

      @github_user = github_user
      @repos = repos
      @organizations = orgs
      @milestones = milestones
      @issues = issues

      slim :dashboard
    end

    get '/issues.csv' do
      content_type 'application/csv'
      attachment 'issues.csv'

      @issues = issues

      csv_string = CSV.generate do |csv|
        csv << ['#', 'Title', 'Creator', 'Assigned to', 'State', 'Labels', 'Created at', 'Updated at']

        @issues.each do |issue|
          csv << [
            issue.number,
            issue.title,
            issue.user.login,
            issue.assignee ? issue.assignee.login : '',
            issue.state,
            issue.labels.any? ? issue.labels.map { |label| label.name }.join(', ') : '',
            issue.created_at,
            issue.updated_at
          ]
        end
      end
    end

    get '/logout' do
      logout!
      redirect 'https://github.com'
    end

    not_found do
      slim :not_found
    end
  end
end
