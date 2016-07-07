# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cavy_item_group, class: Cavy::ItemGroup do
    sequence(:title) { |n| "item_group_#{n+Cavy::ItemGroup.count}" }
    param_string 'name'
  end
end
