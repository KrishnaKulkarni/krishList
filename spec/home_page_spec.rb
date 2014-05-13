require 'spec_helper'


feature 'Home Page' do
  before :each do
    visit '/'
    save_and_open_page
  end

  #requires a selector of class="category"
  it 'displays all the appropriate category titles' do
    KrishList::CATEGORIES.each do |category|
      page.all('.category', text: category)
    end
  end
    
end