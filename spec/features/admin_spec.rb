require 'spec_helper'

module Cavy
  describe 'Admin Interface' do

    describe 'signed in admin user' do

      before(:each) do
        log_in('admin')
      end

      after(:each) do
        log_out
      end

      it 'should be able to go to the home page' do
        visit '/admin'
        expect(page).to have_content('Website Dashboard')
      end

      it 'should be able to click the hompage link in sidebar' do
        visit '/admin'
        click_link 'admin-overview'
        expect(page).to have_content('Website Dashboard')
      end

      it 'should be able to go to the list of pages' do
        visit '/admin'
        click_link 'admin-system'
        click_link 'admin-users'
        expect(page).to have_content('Listing Users')
      end
    end

    describe 'non signed in user' do

      before(:each) do
        @user = FactoryGirl.create(:cavy_user, password: 'secret', password_confirmation: 'secret')
      end

      after(:each) do
        @user.destroy
      end

      it 'should prevent a non signed in user from reaching the admin page and send it to sign in' do
        visit '/admin'
        expect(page).to have_content('Please log in first to view the previous page.')
      end

    end

  end
end