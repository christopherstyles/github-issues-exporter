require 'spec_helper'

RSpec.describe GithubIssuesExporter::Web, type: :feature do
  let(:user) do
    make_user(
      login: 'jimbo',
      name: 'Jimbo Baggins'
    )
  end

  describe 'when viewing the Dashboard' do
    context 'when not signed in' do
      it 'redirects' do
        get '/dashboard'
        expect(last_response).to be_a_redirect
      end

      it 'redirects to github auth' do
        get '/dashboard'
        expect(last_response.location)
          .to match('https://github.com/login/oauth/authorize')
      end
    end

    context 'when signed in' do
      before(:each) do
        login_as(user)
      end

      context 'with no given parameters' do
        it 'shows the user login' do
          visit '/dashboard'
          expect(page).to have_content(user.name)
        end
      end

      context 'when a repo is given' do
        it 'displays open repo issues by default' do
          visit '/dashboard?repo=testrepo'

          # Currently pulling from fixtures
          expect(page).to have_content('Found a bug')
        end
      end
    end
  end
end
