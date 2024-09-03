require 'rails_helper'

RSpec.feature "WorkExperiences", type: :feature do 
  describe 'Work Experiences' do
    describe 'Current user' do
      before :each do 
        @user = create(:user)
        sign_in(@user)
        sleep 3
      end

      it 'should open the work experience form and display the validation errors if empty form is submitted' do 
        visit "/member/#{@user.id}"
        expect(page).to have_text('Work Experiences')
        find('a[data-controller="bs-modal-form"] i.bi.bi-plus').click
        sleep 3
        expect(page).to have_text('Add new work experience')
        click_button 'Save Changes'
        sleep 3
        expect(page).to have_text('9 errors prohibited your work experience from being saved')
        expect(page).to have_text("Company can't be blank")
        expect(page).to have_text("Start date can't be blank")
        expect(page).to have_text("Job title can't be blank")
        expect(page).to have_text("Location can't be blank")
        expect(page).to have_text("Employment type can't be blank")
        expect(page).to have_text("Employment type not a valid employment type")
        expect(page).to have_text("Location type can't be blank")
        expect(page).to have_text("Location type not a valid location type")
        expect(page).to have_text("End date must be present if you are not currently working in this company")
        sleep 3
      end

      it 'should open the work experience form and save into db if all the validation get passed' do 
        visit "/member/#{@user.id}"
        expect(page).to have_text('Work Experiences')
        find('a[data-controller="bs-modal-form"] i.bi.bi-plus').click
        sleep 3
        expect(page).to have_text('Add new work experience')

        fill_in 'work_experience_job_title', with: 'Senior Ruby on Rails developer'
        fill_in 'work_experience_company', with: 'Developer Community PVT. LTD.'
        select 'Full-Time', from: 'work_experience_employment_type'
        fill_in 'work_experience_location', with: 'Indore, India'
        select 'Remote', from: 'work_experience_location_type'
        fill_in 'work_experience_start_date', with: '01/01/2018'
        fill_in 'work_experience_end_date', with: '01/01/2020'
        fill_in 'work_experience_description', with: 'i worked here for two years as a full stack Ruby on Rails developer'
        click_button 'Save Changes'
        sleep 10
        visit "/member/#{@user.id}"

        expect(page).to have_text('Senior Ruby on Rails developer')
        expect(page).to have_text('Developer Community PVT. LTD. (Full-Time)')
        expect(page).to have_text('Indore, India (Remote)')
        expect(page).to have_text('Jan 2020 - Jan 2018')
      end
    end
  end
end
