# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cavy_page, :class => 'Page' do
    content "MyString"
    title "MyString"
  end
end
