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

module Cavy
  class User < ::ActiveRecord::Base
    has_and_belongs_to_many :cavy_groups, class_name: 'Cavy::Group', foreign_key: 'cavy_user_id', association_foreign_key: 'cavy_group_id'

    has_secure_password

    validates :email, uniqueness: true, presence: true
    validates :name, presence: true
    validates :password, presence: true, on: :create

    before_create { generate_token(:auth_token) }

    @@dev_team = %w[developer designer admin]
    @@managers = @@dev_team + ['client']

    def dev_team?
      return true if @@dev_team.include?(role)
      false
    end

    def site_manager?
      return true if @@managers.include?(role)
      false
    end

    private

    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.where(column => self[column]).exists?
    end
  end
end
