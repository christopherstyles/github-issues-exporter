require 'octokit'

# :nodoc:
class GithubApi
  attr_reader :client

  def initialize(token)
    @client = Octokit::Client.new(access_token: token)
  end
end
