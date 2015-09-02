require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  test "the index with no search params" do
    get :index
    assert_response :ok
    assert_equal "Please search for something (e.g. 'uber', 'uber vs. lyft', or 'airlines').", flash[:alert]
    assert_not_equal "FOOBAR One or more FOOBAR of your item(s) is not currently in our database. Please sign in to continue FOOBAR.", flash[:alert]  
  end

  test "the index with search params" do
    get :index, search: 'uber vs. lyft'
    assert_response :ok
    assert_equal "One or more of your item(s) is not currently in our database. Please sign in to continue.", flash[:alert] 
    assert_not_equal "FOOBAR One or more FOOBAR of your item(s) is not currently in our database. Please sign in to continue FOOBAR.", flash[:alert] 
  end

  test "the index with search params which is a category" do
  	category = Category.create!(name: 'airlines')
  	assert Category.where("name LIKE ?", "%airlines%").exists?
  	item = Item.create!(name: 'delta')
   	Rating.create!(item_id: item.id, x_rating: 0.5, y_rating: 0.5)
  	ItemsCategory.create!(item_id: item.id, category_id: category.id)
  	assert_not_equal 0,Item.search('airlines').count
    get :index, search: 'airlines'
    assert_response :ok
  end

  test "the index with search params for multiple items" do
  	category = Category.create!(name: 'airlines')
  	assert Category.where("name LIKE ?", "%airlines%").exists?
  	item = Item.create!(name: 'delta')
   	Rating.create!(item_id: item.id, x_rating: 0.5, y_rating: 0.5)
  	ItemsCategory.create!(item_id: item.id, category_id: category.id)
  	assert_not_equal 0,Item.search('airlines').count
    get :index, search: 'delta vs foobar'
    assert_response :ok
  end

end
 




