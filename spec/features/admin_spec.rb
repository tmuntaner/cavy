require 'spec_helper'

module Cavy
  describe 'Admin Interface' do
    describe 'signed in admin user' do
      before do
        log_in('admin')
      end

      after do
        log_out
      end

      it 'is able to go to the list of pages' do
        visit '/admin'
        click_link 'admin-system'
        click_link 'admin-users'
        expect(page).to have_content('Listing Users')
      end
    end

    describe 'non signed in user' do
      before do
        @user = FactoryGirl.create(:cavy_user, password: 'secret', password_confirmation: 'secret')
      end

      after do
        @user.destroy
      end

      it 'prevents a non signed in user from reaching the admin page and send it to sign in' do
        visit '/admin'
        expect(page).to have_content('Please log in first to view the previous page.')
      end
    end
  end
end
