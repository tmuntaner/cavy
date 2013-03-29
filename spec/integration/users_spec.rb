require 'spec_helper'

module Cavy
  describe 'Users' do

    describe 'sign in process' do
      it "should allow a user to go to the signin page" do
        visit '/admin/signin'
        page.driver.status_code.should eq(200)
      end

      it "should allow a user to sign into the website" do
        visit '/admin/signin'
        @user = FactoryGirl.create(:cavy_user, password: 'secret', password_confirmation: 'secret')
        fill_in 'user-email', with: @user.email
        fill_in 'user-password', with: 'secret'
        click_button 'sign-in'
        page.should_not have_content('Email or password is invalid')
      end

      it "should not allow a user to sign in with an invalid password" do
        visit '/admin/signin'
        @user = FactoryGirl.create(:cavy_user, password: 'secret', password_confirmation: 'secret')
        fill_in 'user-email', with: 'foo@bar.com'
        fill_in 'user-password', with: 'secret1'
        click_button 'sign-in'
        page.should have_content('Email or password is invalid')
      end

    end

    describe 'sign out process' do
      it "should sign out signed in users" do
        log_in('admin')
        visit admin_overview_path
        click_link 'log-out'
        page.should have_content('Logged out')
      end
    end

    describe 'role check' do

      describe 'dev team' do
        after(:each) do
          log_out
        end

        it "should return true in check for dev team member if developer" do
          log_in('developer')
          current_user.dev_team?.should be_true
        end

        it "should return true in check for dev team member if designer" do
          log_in('designer')
          current_user.dev_team?.should be_true
        end

        it "should return true in check for dev team member if admin" do
          log_in('admin')
          current_user.dev_team?.should be_true
        end

        it "should return false in check for dev team member if client" do
          log_in('client')
          current_user.dev_team?.should be_false
        end

      end

      describe 'site managers' do
        after(:each) do
          log_out
        end

        it "should return true in check for manager member if developer" do
          log_in('developer')
          current_user.site_manager?.should be_true
        end

        it "should return true in check for manager member if designer" do
          log_in('designer')
          current_user.site_manager?.should be_true
        end

        it "should return true in check for manager member if admin" do
          log_in('admin')
          current_user.site_manager?.should be_true
        end

        it "should return true in check for manager member if client" do
          log_in('client')
          current_user.site_manager?.should be_true
        end

      end

    end

    # describe 'sign up process' do
    #   it "should allow a user to sign up to"
    # end

  end
end