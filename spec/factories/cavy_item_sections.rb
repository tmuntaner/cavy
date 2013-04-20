# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cavy_item_section, :class => Cavy::ItemSection do
    title 'MyString'
  end
end
