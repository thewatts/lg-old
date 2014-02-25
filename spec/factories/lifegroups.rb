# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :lifegroup do
    name "My Life Group"
    description "My Description"
    number "12345"
    association :semester, :factory => :semester
  end
end
