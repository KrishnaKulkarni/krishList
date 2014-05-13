require 'spec_helper'


feature 'Post-Ad Page' do
  before :each do
    Category.create!(title: "housing").subcats.create!(title: 'apts / housing')
    sign_up_as_test_user
    visit '/'
    page.click_on('post')
  end

  #requires a selector of class="category"
  it 'displays the path in the header' do
    find('header').should have_content('new ad')
  end
   
   # requires javascript 
  it 'displays the path in the header' do
    select('housing', from: 'category')
    save_and_open_page
    select('apts / housing', from: 'subcategory')
    save_and_open_page
  end  
    
end