FactoryGirl.define do
  factory :cavy_user, class: Cavy::User do
    sequence(:name) { |n| "foo#{n+Cavy::User.count}" }
    password 'foobar'
    password_confirmation 'foobar'
    email { "#{name}@foo.bar" }
    role 'client'
  end
end