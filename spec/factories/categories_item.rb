# has_many => through association
 
FactoryGirl.define :categories_items do |f|
   f.association :category
   f.association :item
end