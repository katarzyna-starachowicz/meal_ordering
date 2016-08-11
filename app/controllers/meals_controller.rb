class MealsController < ApplicationController
  before_action :authorize!

  def new
    @meal     = Meal.new
    @order_id = order_id_params.to_i
  end

  def create
    @meal = current_user.meals.new(meal_params)
    if @meal.save
      redirect_to orders_path
    else
      render :new
    end
  end

  private

  def order_id_params
    params.require(:order_id)
  end

  def meal_params
    params.require(:meal).permit(:name, :price, :order_id)
  end
end
