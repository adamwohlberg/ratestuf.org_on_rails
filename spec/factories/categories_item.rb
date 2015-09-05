FactoryGirl.define do
  factory :category_item do
   association :category
   association :item
  end
end