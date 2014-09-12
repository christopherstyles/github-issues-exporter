require 'spec_helper'

RSpec.describe 'External request', feature: true do
  it 'queries organization repos on Github' do
    uri = URI('https://api.github.com/orgs/github/repos')

    response = JSON.load(Net::HTTP.get(uri))

    expect(response.first['owner']['login']).to eq 'octocat'
  end
end
