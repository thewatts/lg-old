# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lifegroup do
    name "My Life Group"
    description "My Description"
    number "12345"
    semester_id 1
  end
end
