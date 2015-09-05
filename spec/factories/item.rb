FactoryGirl.define do
  factory :item do
    name "uber"
    url  "http://www.uber.com"
    category
    after :create do |s|
        s.ratings << FactoryGirl.create(:rating)
    end
  end
end