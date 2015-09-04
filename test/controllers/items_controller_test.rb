require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  # case user NOT logged in
  test 'user is not logged in and attempts to search with empty search params' do
    get(:index, search: '')
    assert_response :ok
    assert_equal "Please search for something (e.g. 'uber', 'uber vs. lyft', or 'airlines') to rate.", flash[:alert]
    assert_not_equal 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', flash[:alert]
  end

  test 'user is not logged in and searches for an item which does exist in the db' do
    get(:index, search: items(:uber).name )
    assert_response :ok
    assert_equal nil, flash[:alert]
    assert_not_equal 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', flash[:alert]
  end

  # test 'user is not logged in and searches for two items which do exist in the db' do
  #   Item.create!(name: 'uber')
  #   Item.create!(name: 'lyft')
  #   get :index, search: 'uber vs. lyft'
  #   assert_response :ok
  #   assert_equal nil, flash[:alert]
  #   assert_not_equal 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', flash[:alert]
  # end

  # test "user is not logged in and searches for two items one of which is new to the db" do
  #   Item.create!(name: 'lyft')
  #   get :index, search: 'foobar vs. lyft'
  #   assert_response :ok
  #   assert_equal nil, flash[:alert]
  #   assert_not_equal "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", flash[:alert]
  # end

  # test "user is not logged in and searches for two items which are both new to the db" do
  #   category = Category.create!(name: 'airlines')
  #   assert Category.where("name LIKE ?", "%airlines%").exists?
  #   item = Item.create!(name: 'delta')
  #   Rating.create!(item_id: item.id, x_rating: 0.5, y_rating: 0.5)
  #   ItemsCategory.create!(item_id: item.id, category_id: category.id)
  #   assert_not_equal 0,Item.search('airlines').count
  #   get :index, search: 'delta vs foobar'
  #   assert_response :ok
  # end

  # test "user is not logged in and searches for a term which is a category" do
  # 	category = Category.create!(name: 'airlines')
  # 	assert Category.where("name LIKE ?", "%airlines%").exists?
  # 	item = Item.create!(name: 'delta')
  #  	Rating.create!(item_id: item.id, x_rating: 0.5, y_rating: 0.5)
  # 	ItemsCategory.create!(item_id: item.id, category_id: category.id)
  # 	assert_not_equal 0,Item.search('airlines').count
  #   get :index, search: 'airlines'
  #   assert_response :ok
  # end

  # # case user logged in

  # test 'user is logged in and attempts to search with empty search params' do
  #   get :index, user_id: 1
  #   assert_response :ok
  #   assert_equal "Please search for something (e.g. 'uber', 'uber vs. lyft', or 'airlines') to rate.", flash[:alert]
  #   assert_not_equal 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.', flash[:alert]
  # end
end
