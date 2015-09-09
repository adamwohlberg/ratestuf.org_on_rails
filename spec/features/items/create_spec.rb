require 'rails_helper'

describe 'Searching for and creating items' do

  # case when !user_signed_in?

  it "displays the correct flash message when user is not logged in and searches with an empty search bar" do
  visit root_path
  fill_in(:search, :with => '')
  page.execute_script("$('form#searchTags').submit()")
  expect(page).to have_content("Please search for something")
  end

  it "displays the correct flash message and a draggable ball when user is not logged in and searches for a single item that already exists in the db" do
  visit root_path
  fill_in(:search, :with => 'uber')
  page.execute_script("$('form#searchTags').submit()")
  expect(page).to have_link("uber")
  expect(page).to have_no_link("xxxuberxxx")
  expect(page).to have_no_content("Please search for something")
  end

  it "displays the correct flash message when user is not logged in and searches for a single item that does not exist in the db" do
  visit root_path
  fill_in(:search, :with => 'akdfsfdaxxxxffadsljkda')
  page.execute_script("$('form#searchTags').submit()")
  expect(page).to have_content("One or more of your items is new")
  end
  
  it "displays the correct flash message when user is not logged in and searches for two items in a versus search one of which exists and one of which does not exist in the db" do
  visit root_path
  fill_in(:search, :with => 'uber vs. lyft')
  page.execute_script("$('form#searchTags').submit()")
  expect(page).to have_no_content("Please search for something")
  end

  it "displays the correct flash message when user is not logged in and searches for two items in a versus search neither of which exists in the db" do
  visit root_path
  fill_in(:search, :with => 'adlfdajfdfd vs adsfasddfdfsafdsddsfdfs')
  page.execute_script("$('form#searchTags').submit()")
  end

  it "displays the correct flash message when user is not logged in and searches for a single item which is a category" do
  visit root_path
  fill_in(:search, :with => 'airlines')
  page.execute_script("$('form#searchTags').submit()")
  end

  it "displays the correct flash message when user is not logged in and searches for two items the first of which is a category and the second of which exists in the db" do
  visit root_path
  fill_in(:search, :with => 'airlines vs uber')
  page.execute_script("$('form#searchTags').submit()")
  end

  it "displays the correct flash message when user is not logged in and searches for two items the first of which exists in the db and the second of which is a category" do
  visit root_path
  fill_in(:search, :with => 'uber vs. airlines')
  page.execute_script("$('form#searchTags').submit()")
  end

  it "displays the correct flash message when user is not logged in and searches for two items the first of which does not exist in the db and the second of which is a category" do
  visit root_path
  fill_in(:search, :with => 'adfkldadfsfdfdasafdsfdsadfs vs. airlines')
  page.execute_script("$('form#searchTags').submit()")
  end

  it "displays the correct flash message when user is not logged in and searches for two items the first of which is a category and the second of which does not exist in the db" do
  visit root_path
  fill_in(:search, :with => 'airlines vs zzzadfkldzzzzafdsfdsadfs')
  page.execute_script("$('form#searchTags').submit()")
  end

  # case when user_signed_in?

  it "displays the correct flash message when user is not logged in and searches with an empty search bar" do
  user = FactoryGirl.create(:user)
  visit root_path
  click_link('Login')
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  fill_in "Password confirmation", with: user.password
  click_button "Sign up"
  visit root_path
  fill_in(:search, :with => '')
  page.execute_script("$('form#searchTags').submit()")
  expect(page).to have_content("Please search for something (e.g. 'uber', 'uber vs. lyft', or 'airlines') to rate.")
  end

  # NOTE:
  # A logged in search for a "airlines vs. adsjkfjkjads or ajadl;adklfa vs. airlines" aka a category with a non-existent item creates a redirect loop error

end