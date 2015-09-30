require 'rails_helper'

describe 'Searching for and creating items' do
  context 'case when !user_signed_in?' do

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
      FactoryGirl.create(:category_with_items, name: 'airlines')
      visit root_path
      fill_in(:search, :with => 'airlines')
      page.execute_script("$('form#mainForm').submit()")
      expect(page).not_to have_css('p.alert')  
      expect(page).not_to have_css('p.notice')
      expect(page).to have_selector('.draggable', count: 3)
      expect(page).not_to have_selector('.draggable', count: 4)
    end

    it "displays the correct flash message when user is not logged in and searches for two items the first of which is a category and the second of which exists in the db" do
      c = FactoryGirl.create(:category_with_items, name: 'airlines')
      visit root_path
      fill_in(:search, :with => "airlines vs #{c.items.last.name}")
      page.execute_script("$('form#mainForm').submit()")
      expect(page).not_to have_css('p.alert')  
      expect(page).not_to have_css('p.notice')
      expect(page).to have_selector('.draggable', count: 4)
    end

    it "displays the correct flash message when user is not logged in and searches for two items the first of which exists in the db and the second of which is a category" do
      c = FactoryGirl.create(:category_with_items, name: 'airlines')
      visit root_path
      fill_in(:search, :with => "airlines vs #{c.items.last.name}")
      page.execute_script("$('form#mainForm').submit()")
      expect(page).not_to have_css('p.alert')  
      expect(page).not_to have_css('p.notice')
      expect(page).to have_selector('.draggable', count: 4)
    end
  end

  context 'case when user_signed_in?' do
    before(:all) do
      user = FactoryGirl.create(:user)
      visit new_user_session_path
      fill_in(:user_email, with: user.email)
      fill_in(:user_password, with: user.password)
      click_button('Log in')
    end

    it "displays the correct flash message when user is logged in and searches with an empty search bar" do
      visit root_path
      fill_in(:search, :with => '')
      page.execute_script("$('form#mainForm').submit()")
      expect(page).to have_content("Please search for something (e.g. 'uber', 'uber vs. lyft', or 'airlines') to rate.")
      expect(page).not_to have_content("Ipsum factum")
    end

    it "displays a draggable ball when user is logged in and searches for a single item that already exists in the db" do
      visit root_path
      item = FactoryGirl.create(:item, name: 'uber', url: 'www.uber.com', user_id: 1)
      puts Item.find_by(name: "uber").inspect
      fill_in(:search, with: "uber")
      page.execute_script("$('form#mainForm').submit()")
      expect(page).to have_link("uber")
    end

    # it "displays the correct flash message when user is logged in and searches for a single item that does not exist in the db" do
    #   visit root_path
    #   fill_in(:search, with: 'test_123')
    #   page.execute_script("$('form#mainForm').submit()")
    #   expect(page).to have_link('test_123')
    #   expect(page).to have_css('p.notice', text: 'Your new item(s) are now added to our database. Thanks!')
    # end

    it "displays the correct flash message when user is logged in and searches for two items in a versus search one of which exists and one of which does not exist in the db" do
      visit root_path
      fill_in(:search, :with => 'uber vs. asdfkjldakjs')
      page.execute_script("$('form#mainForm').submit()")
      expect(page).to have_link('uber')
      expect(page).not_to have_css('p.notice')
    end

    # it "displays the correct flash message when user is logged in and searches for two items in a versus search neither of which exists in the db" do
    #   visit root_path
    #   fill_in(:search, :with => 'zzzzzzzzzzzz vs xxxxxxxxxxxxx')
    #   page.execute_script("$('form#mainForm').submit()")
    #   expect(page).to have_link('zzzzzzzzzzzz')
    #   expect(page).to have_link('xxxxxxxxxxxxx')
    #   expect(page).to have_css('p.notice', text: 'Your new item(s) are now added to our database. Thanks!')
    # end

    it "displays the correct flash message when user is logged in and searches for a single item which is a category that does exist in the db" do
      FactoryGirl.create(:category_with_items, name: 'airlines')
      visit root_path
      fill_in(:search, :with => 'airlines')
      page.execute_script("$('form#mainForm').submit()")
      expect(page).not_to have_css('p.alert')  
      expect(page).not_to have_css('p.notice')
      expect(page).to have_selector('.draggable', count: 3)
      expect(page).not_to have_selector('.draggable', count: 4)
    end

    it "displays the correct flash message when user is logged in and searches for two items the first of which is a category and the second of which exists in the db" do
      c = FactoryGirl.create(:category_with_items, name: 'airlines')
      visit root_path
      fill_in(:search, :with => "airlines vs #{c.items.last.name}")
      page.execute_script("$('form#mainForm').submit()")
      expect(page).not_to have_css('p.alert')  
      expect(page).not_to have_css('p.notice')
      expect(page).to have_selector('.draggable', count: 4)
    end

    it "displays the correct flash message when user is logged in and searches for two items the first of which exists in the db and the second of which is a category" do
      c = FactoryGirl.create(:category_with_items, name: 'airlines')
      visit root_path
      fill_in(:search, :with => "airlines vs #{c.items.last.name}")
      page.execute_script("$('form#mainForm').submit()")
      expect(page).not_to have_css('p.alert')  
      expect(page).not_to have_css('p.notice')
      expect(page).to have_selector('.draggable', count: 4)
    end
  end
end
