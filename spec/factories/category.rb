FactoryGirl.define do
  factory :category do
    name { FFaker::Company.name }

    factory :category_with_items do 
    	after(:create) do |category, iterator|
    		3.times do 
					item = FactoryGirl.create(:item_with_ratings)
					FactoryGirl.create(:categories_item, item: item, category: category) 			
    		end
    	end
    end
  end
end
