class OrdersController < ApplicationController
  before_action :authorize!

  def index
    @orders = Order.all
  end
end
