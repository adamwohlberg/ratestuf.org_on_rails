FactoryGirl.define do
  factory :rating do
    x_rating 0.5
    y_rating 0.5
    item
    user
  end
end
