require 'spec_helper'

module Cavy
  describe User do
    
    it "should make a user with proper password and email" do
      @user = User.create(password: 'secret', password_confirmation: 'secret', email: 'sdfdf@sss.com')
      @user.should be_valid
      @user.destroy
    end

    it "should only make a user with an email" do
      @user = User.create(password: 'secret', password_confirmation: 'secret')
      @user.should_not be_valid
      @user.destroy
    end

    it "should ensure unique emails" do
      @user = User.create(password: 'secret', password_confirmation: 'secret', email: 'sdfdf@sss.com')
      @user.should be_valid
      @user2 = User.create(password: 'secret', password_confirmation: 'secret', email: 'sdfdf@sss.com')
      @user2.should_not be_valid
      @user.destroy
    end

    it "should check if passwords are the same" do
      @user = User.create(password: 'secret1', password_confirmation: 'secret2', email: 'sdfdf@sss.com')
      @user.should_not be_valid
      @user.destroy
    end

    it "should authenticate user with proper password" do
      @user = User.create(password: 'secret', password_confirmation: 'secret', email: 'sdfdf@sss.com')
      @user.authenticate('secret').should be_true
    end

    it "should not authenticate user with proper password" do
      @user = User.create(password: 'secret', password_confirmation: 'secret', email: 'sdfdf@sss.com')
      @user.authenticate('secret1').should_not be_true
    end

  end
end
