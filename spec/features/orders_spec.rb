require 'rails_helper'

feature 'orders creating process' do
  before { login_with_oauth }

  scenario 'user can create valid order' do
    visit orders_path
    click_link '...or create a new order'
    fill_in 'Restaurant name', with: 'KFC'
    fill_in 'Restaurant link', with: 'http://kfc.pl/'
    click_button 'Create!'

    expect(page).to have_content 'KFC'
  end

  scenario 'user can not create invalid order' do
    visit orders_path
    click_link '...or create a new order'
    fill_in 'Restaurant name', with: 'KFC'
    fill_in 'Restaurant link', with: 'invalid url'
    click_button 'Create!'

    expect(page).to have_content '1 error'
  end
end
