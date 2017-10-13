# == Schema Information
#
# Table name: cavy_groups
#
#  id             :integer          not null, primary key
#  name           :string
#  is_super_admin :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

module Cavy
  class Group < ::ActiveRecord::Base

    has_and_belongs_to_many :cavy_users, class_name: 'Cavy::User', foreign_key: 'cavy_group_id', association_foreign_key: 'cavy_user_id'
    has_and_belongs_to_many :cavy_policies, class_name: 'Cavy::Policy', foreign_key: 'cavy_group_id', association_foreign_key: 'cavy_policy_id'

  end
end
