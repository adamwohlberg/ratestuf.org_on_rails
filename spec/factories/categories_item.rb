FactoryGirl.define do
  factory :categories_item do
   association :category
   association :item
  end
end

