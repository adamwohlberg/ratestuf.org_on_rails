FactoryGirl.define do
  factory :user do
  	first_name { FFaker::Name.first_name }
    email { FFaker::Internet.disposable_email } 
    password  "asdfjkl;"
  end
end
