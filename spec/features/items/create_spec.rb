require 'spec_helper'
require 'rails_helper'

describe "user interacts with the landing page" do

	it "displays the landing page correctly" do
	visit root_path
	expect(page).to have_content("rate brands and find the best stuf")
	expect(page).to have_no_content("Lorem ipsum dolor sit amet.")
	end

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
  item = FactoryGirl.create(:item)
  rating = FactoryGirl.create(:rating)

  user = FactoryGirl.create(:user)
  expect(flash[:notice]).to be_present
  expect(page).to have_content(item.name)
  end

  # it "displays the correct flash message when user is not logged in and searches for a single item that does not exist in the db" do
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

end