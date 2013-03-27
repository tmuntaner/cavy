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
        @user = Cavy::User.create(email: 'foo@bar.com', password: 'secret', password_confirmation: 'secret')
        fill_in 'user-email', with: 'foo@bar.com'
        fill_in 'user-password', with: 'secret'
        click_button 'sign-in'
        page.should_not have_content('Email or password is invalid')
      end

      it "should not allow a user to sign in with an invalid password" do
        visit '/admin/signin'
        @user = Cavy::User.create(email: 'foo@bar.com', password: 'secret', password_confirmation: 'secret')
        fill_in 'user-email', with: 'foo@bar.com'
        fill_in 'user-password', with: 'secret1'
        click_button 'sign-in'
        page.should have_content('Email or password is invalid')
      end

    end

  end
end