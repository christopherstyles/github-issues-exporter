require 'sinatra/base'

class FakeGitHub < Sinatra::Base
  get '/user/repos' do
    json_response 200, 'repos.json'
  end

  get '/user/orgs' do
    json_response 200, 'orgs.json'
  end

  get '/orgs/:org/repos' do
    json_response 200, 'org_repos.json'
  end

  get '/repos/:owner/:repo/issues' do
    json_response 200, 'repo_issues.json'
  end

  get '/repos/testrepo/milestones' do
    json_response 200, 'milestones.json'
  end

  get '/issues' do
    json_response 200, 'repo_issues.json'
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/fixtures/' + file_name, 'rb').read
  end
end
