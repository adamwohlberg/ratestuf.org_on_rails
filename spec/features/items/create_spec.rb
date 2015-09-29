require 'rails_helper'

describe 'Searching for and creating items' do
  # case when !user_signed_in?

  it "displays the correct flash message when user is not logged in and searches with an empty search bar" do
  visit root_path
  fill_in(:search, :with => '')
  page.execute_script("$('form#mainForm').submit()")
  expect(page).to have_content("Please search for something (e.g. 'uber', 'uber vs. lyft', or 'airlines') to rate.")
  expect(page).not_to have_content("Ipsum factum")
  end

  it "displays a draggable ball when user is not logged in and searches for a single item that already exists in the db" do
  visit root_path
  item = FactoryGirl.create(:item, name: 'uber', url: 'www.uber.com', user_id: 1)
  puts Item.find_by(name: "uber").inspect
  fill_in(:search, with: "uber")
  page.execute_script("$('form#mainForm').submit()")
  expect(page).to have_link("uber")
  end

  it "displays the correct flash message when user is not logged in and searches for a single item that does not exist in the db", js: true do
  visit root_path
  fill_in(:search, :with => 'test_123')
  page.execute_script("$('form#mainForm').submit()")
  expect(page).to have_no_link('test_123')
  expect(page).to have_css('p.alert', text: 'One or more of your items is new to our system. You must log in to complete this search.')
  end

  it "displays the correct flash message when user is not logged in and searches for two items in a versus search one of which exists and one of which does not exist in the db" do
  visit root_path
  fill_in(:search, :with => 'uber vs. asdfkjldakjs')
  page.execute_script("$('form#mainForm').submit()")
  expect(page).to have_css('p.alert', text: 'One or more of your items is new to our system. You must log in to complete this search.') 
  end

  it "displays the correct flash message when user is not logged in and searches for two items in a versus search neither of which exists in the db" do
  visit root_path
  fill_in(:search, :with => 'adlfdajfdfd vs adsfasddfdfsafdsddsfdfs')
  page.execute_script("$('form#mainForm').submit()")
  expect(page).to have_css('p.alert', text: 'One or more of your items is new to our system. You must log in to complete this search.') 
  end

  it "displays the correct flash message when user is not logged in and searches for a single item which is a category that does exist in the db" do
  FactoryGirl.create(:categories_item, item: { name: "delta", url: "www.delta.com" } )

  visit root_path
  fill_in(:search, :with => 'airlines')
  page.execute_script("$('form#mainForm').submit()")
  expect(page).not_to have_css('p.alert')  
  expect(page).not_to have_css('p.notice') 
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
