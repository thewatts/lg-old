# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    uid "12345"
    name "Nathaniel Watts"
    nickname "nickname"
    email "contact@example.com"
    provider "facebook"
    display_name "Nathaniel Watts"
  end
end
