require 'spec_helper'


feature 'Home Page' do
  before :each do
    sign_up_as_test_user
    visit '/'
    page.click_on('apts / housing')
  end

  #requires a selector of class="category"
  it 'displays the path in the header' do
    find('header').should have_content('apts / housing')
  end
    
end