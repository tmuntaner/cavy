require 'spec_helper'

module Cavy
  describe 'Users' do

    describe 'sign in process' do

      before(:each) do
        @user = FactoryGirl.create(:cavy_user, password: 'secret', password_confirmation: 'secret')
      end

      after(:each) do
        @user = FactoryGirl.create(:cavy_user, password: 'secret', password_confirmation: 'secret')
      end

      it 'should allow a user to go to the signin page' do
        visit '/admin/signin'
        expect(page.driver.status_code).to eq(200)
      end

      it 'should allow a user to sign into the website' do
        visit '/admin/signin'
        @user = FactoryGirl.create(:cavy_user, password: 'secret', password_confirmation: 'secret')
        fill_in 'user-email', with: @user.email
        fill_in 'user-password', with: 'secret'
        click_button 'sign-in'
        expect(page).to_not have_content('Email or password is invalid')
      end

      it 'should not allow a user to sign in with an invalid password' do
        visit '/admin/signin'
        @user = FactoryGirl.create(:cavy_user, password: 'secret', password_confirmation: 'secret')
        fill_in 'user-email', with: 'foo@bar.com'
        fill_in 'user-password', with: 'secret1'
        click_button 'sign-in'
        expect(page).to have_content('Email or password is invalid')
      end
    end

    describe 'sign out process' do
      it 'should sign out signed in users' do
        log_in('admin')
        visit admin_dashboard_path
        click_link 'log-out'
        expect(page).to have_content('Logged out')
      end
    end

    describe 'role check' do
      describe 'dev team' do
        after(:each) do
          log_out
        end

        it 'should return true in check for dev team member if developer' do
          log_in('developer')
          expect(current_user.dev_team?).to be_truthy
        end

        it 'should return true in check for dev team member if designer' do
          log_in('designer')
          expect(current_user.dev_team?).to be_truthy
        end

        it 'should return true in check for dev team member if admin' do
          log_in('admin')
          expect(current_user.dev_team?).to be_truthy
        end

        it 'should return false in check for dev team member if client' do
          log_in('client')
          expect(current_user.dev_team?).to be_falsey
        end
      end

      describe 'site managers' do
        after(:each) do
          log_out
        end

        it 'should return true in check for manager member if developer' do
          log_in('developer')
          expect(current_user.site_manager?).to be_truthy
        end

        it 'should return true in check for manager member if designer' do
          log_in('designer')
          expect(current_user.site_manager?).to be_truthy
        end

        it 'should return true in check for manager member if admin' do
          log_in('admin')
          expect(current_user.site_manager?).to be_truthy
        end

        it 'should return true in check for manager member if client' do
          log_in('client')
          expect(current_user.site_manager?).to be_truthy
        end
      end

      describe 'new users' do
        it 'should be able to create a new user' do
          log_in('admin')
          visit cavy_admin_new_user_path
          fill_in 'user_name', with: 'user name'
          fill_in 'user_email', with: 'name@gmail.com'
          fill_in 'user_password', with: 'secret'
          fill_in 'user_password_confirmation', with: 'secret'
          fill_in 'user_role', with: 'admin'
          click_button 'Save'
          user = Cavy::User.last
          expect(user.name).to eq('user name')
          user.destroy
        end
        it 'should not be able to create a new user without a matching password' do
          log_in('admin')
          count = Cavy::User.count
          visit cavy_admin_new_user_path
          fill_in 'user_name', with: 'user name'
          fill_in 'user_email', with: 'name@gmail.com'
          fill_in 'user_password', with: 'secret'
          fill_in 'user_password_confirmation', with: 'secret1'
          fill_in 'user_role', with: 'admin'
          click_button 'Save'
          expect(Cavy::User.count).to eq(count)
        end

        it 'should be able to update a user' do
          log_in('admin')
          user = FactoryGirl.create(:cavy_user)
          visit edit_user_path(locale: :en, id: user.id)
          fill_in 'user_name', with: 'user name test'
          click_button 'Save'
          expect(Cavy::User.last.name).to eq('user name test')
          user.destroy
        end
        it 'should not be able to update a user without a matching password' do
          log_in('admin')
          user = FactoryGirl.create(:cavy_user)
          digest = user.password_digest
          visit edit_user_path(locale: :en, id: user.id)
          fill_in 'user_password', with: 'secret'
          fill_in 'user_password_confirmation', with: 'secret1'
          click_button 'Save'
          expect(Cavy::User.last.password_digest).to eq(digest)
          user.destroy
        end
      end

    end

  end
end
