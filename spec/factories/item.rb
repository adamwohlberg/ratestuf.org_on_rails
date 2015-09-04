FactoryGirl.define do
  factory :items do
    name "uber"
    url  "http://www.uber.com"
    category

    factory :items_with_ratings do
    	transient do
    		items_count 5
    	end

    	after(:create) do ||
    		create_list(:rating, evaluator.ratings_count, items: category)
    	end
    end
  end
end