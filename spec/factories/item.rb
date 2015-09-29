FactoryGirl.define do
  factory :item do
    name { FFaker::Name.name }
    url  { FFaker::InternetSE.http_url }

    factory :item_with_ratings do 
    	after(:create) do |item, iterator|
    		3.times do 
					rating = FactoryGirl.create(:rating, item: item )	
    		end
    	end
    end
   end
 end