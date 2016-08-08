require 'rails_helper'

feature 'the signing process' do
  scenario 'after log in user is on orders index page and can see his name' do
    login_with_oauth
    expect(page).to have_content 'Zofia'
    expect(page).to have_content 'Log out'
  end

  scenario "not logged user sees 'Log in via GitHub'" do
    login_with_oauth
    click_link 'Log out'
    visit root_path
    expect(page).to have_content 'Log in via GitHub'
  end
end
