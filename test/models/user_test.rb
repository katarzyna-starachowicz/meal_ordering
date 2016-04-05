require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @invalid_user = User.new(name: "")
  end

  test "should be valid" do
    assert users(:zosia).valid?
  end

  test "should be invalid" do
    assert_not @invalid_user.valid?
  end
end
