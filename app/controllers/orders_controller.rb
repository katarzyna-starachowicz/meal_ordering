class OrdersController < ApplicationController
  before_action :authorize!

  def index
    @active_orders  = OrderQuery.new.active
    @history_orders = OrderQuery.new.history
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
