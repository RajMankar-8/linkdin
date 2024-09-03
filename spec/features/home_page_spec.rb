require 'rails_helper'

RSpec.feature "HomePages", type: :feature do
  describe 'Landing page' do
    it 'should show the login form on root page' do
      visit root_path 
 
      expect(page).to have_text('Log in')
      expect(page).to have_text('Sign up')
      expect(page).to have_text('Forgot your password?')
      expect(page).to have_text("Didn't receive confirmation instructions?")

      expect(page).to_not have_text('Search professionals accross the world!')

      # Sleep for 10 seconds to keep the browser open
      sleep 10
    end
  end
end
