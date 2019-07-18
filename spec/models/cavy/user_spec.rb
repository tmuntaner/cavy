# == Schema Information
#
# Table name: cavy_users
#
#  id              :integer          not null, primary key
#  email           :string
#  name            :string
#  password_digest :string
#  auth_token      :string
#  role            :string
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe Cavy::User do
  it 'makes a user with proper stuff' do
    user = FactoryGirl.create(:cavy_user)
    expect(user).to be_valid
    user.destroy
  end

  describe 'email' do
    it 'does not not make a user without an email' do
      user = FactoryGirl.build(:cavy_user, email: '')
      expect(user).not_to be_valid
      user.destroy
    end

    it 'ensures unique emails' do
      FactoryGirl.create(:cavy_user, email: 'same@same.same')
      user = FactoryGirl.build(:cavy_user, email: 'same@same.same')
      expect(user).not_to be_valid
    end
  end

  describe 'Passwords' do
    it 'checks if passwords are the same' do
      user = FactoryGirl.build(:cavy_user,
                               password: 'secret1',
                               password_confirmation: 'secret2')
      expect(user).not_to be_valid
    end

    it 'authenticates a user with proper password' do
      user = FactoryGirl.build(:cavy_user,
                               password: 'secret',
                               password_confirmation: 'secret')
      expect(user.authenticate('secret')).to be_truthy
    end

    it 'does not authenticate user with proper password' do
      user = FactoryGirl.build(:cavy_user,
                               password: 'secret',
                               password_confirmation: 'secret')
      expect(user.authenticate('secret1')).not_to be_truthy
    end
  end

  describe 'name' do
    it 'accepts a name' do
      user = FactoryGirl.build(:cavy_user, name: 'Foo')
      expect(user).to be_valid
    end

    it 'does not accept a user without a name' do
      user = FactoryGirl.build(:cavy_user, name: '')
      expect(user).not_to be_valid
    end
  end
end
