FactoryGirl.define do
  factory :user do
    email "test@example.com"
    password  "asdfjkl;"
  end
end

FactoryGirl.define do
  factory :category do
    name "new item category undefined"
    item
  end
end

# FactoryGirl.define :categories_item, :class => categories_item do |f|
#    f.association :category
#    f.association :item
# end

FactoryGirl.define do
  factory :item do
    name "uber"
    url  "http://www.uber.com"
    category
  end
end

FactoryGirl.define do
  factory :rating do
    x_rating 0.5
    y_rating 0.5
    item
    user
  end
end