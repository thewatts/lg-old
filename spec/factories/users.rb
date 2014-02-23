# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    uid "12345"
    name "Nathaniel Watts"
    sequence(:nickname) { |n| "nickname-#{n}" }
    sequence(:email) { |n| "email#{n}@factory.com" }
    provider "facebook"
    display_name "Nathaniel Watts"
  end
end
