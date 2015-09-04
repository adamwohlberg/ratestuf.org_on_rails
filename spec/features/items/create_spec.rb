require 'spec_helper'
require 'rails_helper'

describe "user interacts with the landing page" do
	# def create_items(options={})
	# 	options[:name] ||= 'uber'
	# end
 #  before :each do
 #    User.make(:email => 'user@example.com', :password => 'password')
 #    Item.make(:name => 'uber')
 #    Item.make(:name => 'lyft')
 #    Item.make(:name => 'delta')

 #  end

	it "displays the landing page correctly" do
	visit "/"
	expect(page).to have_content("rate brands and find the best stuf")
	expect(page).to have_no_content("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.")
	end

	# case when !user_signed_in?

  it "displays the correct flash message when user is not logged in and searches with an empty search bar" do
  end

  it "displays the correct flash message when user is not logged in and searches for a single item that exists in the db" do
  end

  it "displays the correct flash message when user is not logged in and searches for a single item that does not exist in the db" do
  end

  it "displays the correct flash message when user is not logged in and searches for two items in a versus search one of which exists and one of which does not exist in the db" do
  end

  it "displays the correct flash message when user is not logged in and searches for two items in a versus search neither of which exists in the db" do
  end

  it "displays the correct flash message when user is not logged in and searches for a single item which is a category" do
  end

  it "displays the correct flash message when user is not logged in and searches for two items the first of which is a category and the second of which exists in the db" do
  end

  it "displays the correct flash message when user is not logged in and searches for two items the first of which exists in the db and the second of which is a category" do
  end

  it "displays the correct flash message when user is not logged in and searches for two items the first of which does not exist in the db and the second of which is a category" do
  end

  it "displays the correct flash message when user is not logged in and searches for two items the first of which is a category and the second of which does not exist in the db" do
  end

	# case when user_signed_in?

	# ADD ALL SHIZAT FROM ABOVE INVERSE WHEN USER NOT LOGGED IN

end