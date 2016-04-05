require 'test_helper'

class SessionsTest < ActionDispatch::IntegrationTest
  def setup
    login_user
  end

  test "after log in user is on orders index page and can see his name" do
    assert_equal orders_path, current_path
    assert has_content? "Zofia"
    assert has_content? "Log out"
  end

  test "not logged user can see 'Log in via GitHub'" do
    click_link "Log out"
    visit root_path
    assert has_content? "Log in via GitHub"
  end
end
