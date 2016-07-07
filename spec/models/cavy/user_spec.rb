require 'spec_helper'

module Cavy
  describe User do

    it 'should make a user with proper stuff' do
      @user = FactoryGirl.create(:cavy_user)
      @user.should be_valid
      @user.destroy
    end

    describe 'email' do
      it 'should not make a user without an email' do
        @user = FactoryGirl.build(:cavy_user, email: '')
        @user.should_not be_valid
        @user.destroy
      end

      it 'should ensure unique emails' do
        @user = FactoryGirl.create(:cavy_user, email: 'same@same.same')
        @user.should be_valid
        @user2 = FactoryGirl.build(:cavy_user, email: 'same@same.same')
        @user2.should_not be_valid
      end
    end

    describe 'Passwords' do
      it 'should check if passwords are the same' do
        @user = FactoryGirl.build(:cavy_user, password: 'secret1', password_confirmation: 'secret2')
        @user.should_not be_valid
      end

      it 'should authenticate user with proper password' do
        @user = FactoryGirl.build(:cavy_user, password: 'secret', password_confirmation: 'secret')
        expect(@user.authenticate('secret')).to be_truthy
      end

      it 'should not authenticate user with proper password' do
        @user = FactoryGirl.build(:cavy_user, password: 'secret', password_confirmation: 'secret')
        expect(@user.authenticate('secret1')).not_to be_truthy
      end
    end

    describe 'name' do

      it 'should accept a name' do
        @user = FactoryGirl.build(:cavy_user, name: 'Foo')
        @user.should be_valid
      end

      it 'should not accept a user without a name' do
        @user = FactoryGirl.build(:cavy_user, name: '')
        @user.should_not be_valid
      end

    end

  end
end
