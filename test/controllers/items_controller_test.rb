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

end
 