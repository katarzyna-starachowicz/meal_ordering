class MealValidator
  def initialize(meal)
    @meal = meal
  end

  def validate
    @meal.errors[:base] << 'You can book only one meal per order' if user_has_meal_in_order?
    @meal.errors[:base] << 'You can book meal only when order has booking status' unless order_has_booking_status?
    @meal.errors[:base] << 'You can not book a meal in deleted order' if order_was_deleted?
  end

  private

  def user_has_meal_in_order?
    user_id  = @meal.client_id
    order_id = @meal.order_id
    order    = Order.find(order_id)

    User.find(user_id).meals.map(&:order).include?(order)
  end

  def order_has_booking_status?
    @meal.order.status == 'booking'
  end

  def order_was_deleted?
    @meal.order.deleted?
  end
end
