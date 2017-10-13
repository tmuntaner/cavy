# == Schema Information
#
# Table name: cavy_policies
#
#  id   :integer          not null, primary key
#  name :string
#

module Cavy
  class Policy < ::ActiveRecord::Base

    has_and_belongs_to_many :cavy_groups, class_name: 'Cavy::Group', foreign_key: 'cavy_policy_id', association_foreign_key: 'cavy_group_id'

  end
end
