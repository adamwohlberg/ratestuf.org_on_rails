require 'rails_helper'

describe "user interacts with the landing page" do

 #  Before do 
 #    Item.destroy_all
 #    Rating.destroy_all
 #    Category.destroy_all
 #    User.destroy_all
 #    #  building the parent factories first, and saving them
 #    #  through the join table so that the
 #    #  the join table record is fully created in db.
 #    item = FactoryGirl.build(:item)
 #    category = FactoryGirl.build(:category)
 #    categories_item = FactoryGirl.create(:categories_item)
 #  end

	# it "displays the landing page correctly" do
	# visit root_path
	# expect(page).to have_content("rate brands and find the best stuf")
	# expect(page).to have_no_content("Lorem ipsum dolor sit amet.")
	# end

	# case when !user_signed_in?

  it "displays the correct flash message when user is not logged in and searches with an empty search bar" do
  visit root_path
  form = page.find("form")
    class << form
      def submit!
        Capybara::RackTest::Form.new(driver, native).submit({})
      end
    end
    form.submit!
  expect(page).to have_content("Please search for something (e.g. 'uber', 'uber vs. lyft', or 'airlines') to rate.")
  end

  it "displays the correct flash message when user is not logged in and searches for a single item that exists in the db" do
  visit root_path
  rating = FactoryGirl.create(:rating)
  item = rating.item
  user = rating.user
  form = page.find("form")
  fill_in "form", with: item.name
    class << form
      def submit!
        Capybara::RackTest::Form.new(driver, native).submit({})
      end
    end
    form.submit!
  byebug

  expect(page).to have_content(item.name)
  expect(page).to have_no_content("ipsum bacon factsum")
  end

  # it "displays the correct flash message when user is not logged in and searches for a single item that does not exist in the db" do
  # visit root_path
  # rating = FactoryGirl.create(:rating)
  # item = rating.item
  # user = rating.user
  # expect(page).to have_no_content("ipsum bacon factsum")
  # end

  # it "displays the correct flash message when user is not logged in and searches for two items in a versus search one of which exists and one of which does not exist in the db" do
  # end

  # it "displays the correct flash message when user is not logged in and searches for two items in a versus search neither of which exists in the db" do
  # end

  # it "displays the correct flash message when user is not logged in and searches for a single item which is a category" do
  # end

  # it "displays the correct flash message when user is not logged in and searches for two items the first of which is a category and the second of which exists in the db" do
  # end

  # it "displays the correct flash message when user is not logged in and searches for two items the first of which exists in the db and the second of which is a category" do
  # end

  # it "displays the correct flash message when user is not logged in and searches for two items the first of which does not exist in the db and the second of which is a category" do
  # end

  # it "displays the correct flash message when user is not logged in and searches for two items the first of which is a category and the second of which does not exist in the db" do
  # end

	# case when user_signed_in?

  it "displays the correct flash message when user is not logged in and searches with an empty search bar" do
  user = FactoryGirl.create(:user)
  visit root_path
  form = page.find("form")
    class << form
      def submit!
        Capybara::RackTest::Form.new(driver, native).submit({})
      end
    end
    form.submit!
  expect(page).to have_content("Please search for something (e.g. 'uber', 'uber vs. lyft', or 'airlines') to rate.")
  end

  # NOTE:
  # A logged in search for a "airlines vs. adsjkfjkjads or ajadl;adklfa vs. airlines" aka a category with a non-existent item creates a redirect loop error

end