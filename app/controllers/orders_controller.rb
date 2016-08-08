class OrdersController < ApplicationController
  before_action :authorize!

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    @order = current_user.orders.new(order_params)
    if @order.save
      redirect_to orders_path
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:restaurant_name, :restaurant_link, :status)
  end
end
