RSpec.configure do |config|
  config.before(:each) do
    stub_request(:any, /api.github.com/).to_rack(FakeGitHub)
  end
end

WebMock.disable_net_connect!(allow_localhost: true, allow: 'coveralls.io')
