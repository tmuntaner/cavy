require 'spec_helper'

module Cavy
  describe 'First Time' do

    describe 'welcome screen' do

      it 'should redirect users to welcome screen when not going to a FirstTimeController action' do
        visit '/en/'
        expect(page).to have_current_path(cavy_first_time_welcome_path('en'))
        expect(page).to have_content('Welcome')
        visit '/en/admin'
        expect(page).to have_current_path(cavy_first_time_welcome_path('en'))
        expect(page).to have_content('Welcome')
      end

      it 'should take you to the new user screen from welcome screen' do
        visit '/en/'
        expect(page).to have_current_path(cavy_first_time_welcome_path, {wait: 10})
        click_on 'new-user'
        sleep(0.5)
        expect(page).to have_current_path(cavy_first_time_new_user_path('en'), {wait: 10})
        expect(page).to have_content('Create a New User')
      end

      it 'should only be reachable with no users' do
        visit '/'
        sleep(0.5)
        expect(page).to have_content('Welcome')
        log_in('admin')
        visit '/'
        sleep(0.5)
        expect(page).to_not have_content('Welcome')
      end

    end

    describe 'new user screen' do

      it 'should create a new user' do
        visit '/'
        click_on 'new-user'
        page.should have_content('Create a New User')

        fill_in 'inputName', with: 'foo'
        fill_in 'inputEmail', with: 'foo@bar.com'
        fill_in 'inputPassword', with: 'secret'
        fill_in 'inputPasswordConfirmation', with: 'secret'
        click_on 'signin'

        user = Cavy::User.last

        user.name.should eq('foo')
        user.email.should eq('foo@bar.com')
        expect(user.authenticate('secret')).to be_truthy

      end

      it 'should only be reachable with no users' do
        log_in('admin')
        visit '/first_time/user'
        page.should_not have_content('Create a New User')
      end

    end

  end
end
