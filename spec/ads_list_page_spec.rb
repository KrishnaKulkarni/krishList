require 'spec_helper'


feature 'Ads-List Page' do
  before :each do
    Category.create!(title: "housing").subcats.create!(title: 'apts / housing')
    sign_up_as_test_user
    visit '/'
    page.click_on('apts / housing')
  end

  #requires a selector of class="category"
  it 'displays the path in the header' do
    save_and_open_page
    find('header').should have_content('apts / housing')
  end
    
end