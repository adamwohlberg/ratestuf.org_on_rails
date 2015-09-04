FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "foo#{n}" }
    password 'secret'
    email { "#{username}@example.com" }
  end

  factory :category do
    name 'foo'
  end

  factory :item do
    name 'uber'
    user
    category
  end

  factory :rating do
    item_id
    x_rating 0.5
    y_rating 0.5
    item
  end
end
