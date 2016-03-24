require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @invalid_order = Order.new(restaurant: "")
  end

  test "should be valid" do
    assert orders(:kfc).valid?
  end

  test "should be invalid" do
    assert_not @invalid_order.valid?
  end
end
