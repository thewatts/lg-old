# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Nathaniel Watts"
    nickname "thewatts"
    email "reg@nathanielwatts.com"
    provider "facebook"
  end
end
