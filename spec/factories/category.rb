FactoryGirl.define do
  factory :category do
    name "new item category undefined"

    factory :category_with_items do
    	transient do
    		items_count 5
    	end

    	after(:create) do ||
    		create_list(:item, evaluator.items_count, category: category)
    	end
    end
  end
end