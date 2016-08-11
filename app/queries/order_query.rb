class OrderQuery
  def active
    chronologically_ordered(Order.includes(:meals).active)
  end

  def history
    chronologically_ordered(Order.includes(:meals).history)
  end

  private

  def chronologically_ordered(orders)
    orders.order(:created_at).reverse
  end
end
