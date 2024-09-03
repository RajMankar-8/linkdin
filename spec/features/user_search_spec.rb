require 'rails_helper'

RSpec.feature "UserSearches", type: :feature do
  describe 'User search functionality' do 
    before :each do
      @user = create(:user)
      sign_in(@user)

      @user1 = create(:user, country: "India", city: "Indore")
      @user2 = create(:user, country: "Australia", city: "Sydney")
      @user3 = create(:user, country: "England", city: "London")
      @user4 = create(:user, country: "USA", city: "New york")
      sleep 1
      visit root_path
    end

    describe 'Search by country' do
      it 'should allow users to search others users by country name' do
        fill_in 'q_city_or_country_cont', with: 'India'
        click_button 'Search'

        expect(page).to have_text(@user1.name)
        expect(page).to have_text(@user1.profile_title)
        expect(page).to have_text(@user1.country)

        expect(page).to_not have_text(@user2.country)
        expect(page).to_not have_text(@user3.country)
        expect(page).to_not have_text(@user4.country)
      end

      it 'should allow users to search others users by partial country name' do
        fill_in 'q_city_or_country_cont', with: 'Aus'
        click_button 'Search'

        expect(page).to have_text(@user2.name)
        expect(page).to have_text(@user2.profile_title)
        expect(page).to have_text(@user2.country)

        expect(page).to_not have_text(@user1.country)
        expect(page).to_not have_text(@user3.country)
        expect(page).to_not have_text(@user4.country)
      end

      it 'should allow users to search others users by any random character in the country name' do
        fill_in 'q_city_or_country_cont', with: 'a'
        click_button 'Search'

        expect(page).to have_text(@user1.name)
        expect(page).to have_text(@user1.profile_title)
        expect(page).to have_text(@user2.name)
        expect(page).to have_text(@user2.profile_title)
        expect(page).to have_text(@user3.name)
        expect(page).to have_text(@user3.profile_title)
        expect(page).to have_text(@user4.name)
        expect(page).to have_text(@user4.profile_title)
      end
    end

    describe 'Search by city' do
      it 'should allow users to search others users by city name' do
        fill_in 'q_city_or_country_cont', with: 'Indore'
        click_button 'Search'

        expect(page).to have_text(@user1.name)
        expect(page).to have_text(@user1.profile_title)
        expect(page).to have_text(@user1.country)

        expect(page).to_not have_text(@user2.country)
        expect(page).to_not have_text(@user3.country)
        expect(page).to_not have_text(@user4.country)
      end

      it 'should allow users to search others users by partial city name' do
        fill_in 'q_city_or_country_cont', with: 'Syd'
        click_button 'Search'

        expect(page).to have_text(@user2.name)
        expect(page).to have_text(@user2.profile_title)
        expect(page).to have_text(@user2.country)

        expect(page).to_not have_text(@user1.country)
        expect(page).to_not have_text(@user3.country)
        expect(page).to_not have_text(@user4.country)
      end

      it 'should allow users to search others users by any random character in the city name' do
        fill_in 'q_city_or_country_cont', with: 'n'
        click_button 'Search'

        expect(page).to have_text(@user1.name)
        expect(page).to have_text(@user1.profile_title)
        expect(page).to have_text(@user2.name)
        expect(page).to have_text(@user2.profile_title)
        expect(page).to have_text(@user3.name)
        expect(page).to have_text(@user3.profile_title)
        expect(page).to have_text(@user4.name)
        expect(page).to have_text(@user4.profile_title)
      end
    end

    describe 'view user profile' do
      it 'should search user and visit his profile' do
        fill_in 'q_city_or_country_cont', with: 'India'
        click_button 'Search'

        expect(page).to have_text(@user1.name)
        expect(page).to have_text(@user1.profile_title)
        expect(page).to have_text(@user1.country)

        expect(page).to_not have_text(@user2.country)
        expect(page).to_not have_text(@user3.country)
        expect(page).to_not have_text(@user4.country)

        click_link 'View Profile'

        expect(page).to have_current_path("/member/#{@user1.id}")
        sleep 5
        expect(page).to have_text(@user1.name)
        expect(page).to have_text(@user1.profile_title)
        expect(page).to have_text(@user1.country)
        expect(page).to have_text('About')
        expect(page).to have_text(@user1.about)
        sleep 5
      end
    end
  end
end
