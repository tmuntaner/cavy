# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cavy_admin_item_group, class: Cavy::AdminItemGroup do
    sequence(:title) { |n| "item_group_#{n+Cavy::AdminItemGroup.count}"}
    param_string "name"
  end
end
