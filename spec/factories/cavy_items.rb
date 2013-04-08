# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cavy_item, class: Cavy::Item do
    sequence(:name) { |n| "item#{n+Cavy::Item.count}"}
    data ""
  end
end
