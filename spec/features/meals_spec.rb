require 'rails_helper'

feature 'orders creating process' do
  before do
    login_with_oauth
    click_link '...or create a new order'
    fill_in 'Restaurant name', with: 'KFC'
    fill_in 'Restaurant link', with: 'http://kfc.pl/'
    click_button 'Create!'
    visit orders_path
  end

  scenario 'user creates a meal' do
    user_books_meal

    expect(page).to have_content 'Pizza'
  end

  scenario 'creating the second one in the same order gives error' do
    2.times { user_books_meal }

    expect(page).to have_content 'You can book only one meal per order'
  end

  def user_books_meal
    click_link 'order a meal for yourself'
    fill_in 'Name', with: 'Pizza'
    fill_in 'Price', with: '25'
    click_button 'Create!'
  end
end
