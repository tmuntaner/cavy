module Cavy
  class Group < ::ActiveRecord::Base

    has_and_belongs_to_many :cavy_users, class_name: 'Cavy::User', foreign_key: 'cavy_group_id', association_foreign_key: 'cavy_user_id'
    has_and_belongs_to_many :cavy_policies, class_name: 'Cavy::Policy', foreign_key: 'cavy_group_id', association_foreign_key: 'cavy_policy_id'

  end
end
