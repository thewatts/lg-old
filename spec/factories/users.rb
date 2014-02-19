# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    uid "12345"
    name "Nathaniel Watts"
    nickname "thewatts"
    email "reg@nathanielwatts.com"
    provider "facebook"
  end
end
