FactoryGirl.define do
  factory :user do
  	sequence(:first_name) { |n| "foo#{n}" }
    email { "#{first_name}@example.com" } 
    password  "asdfjkl;"
  end
end
