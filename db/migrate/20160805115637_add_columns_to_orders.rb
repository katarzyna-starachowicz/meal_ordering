class AddColumnsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :creator_id, :integer, index: true
    add_column :orders, :status, :string
    add_column :orders, :deleted_at, :timestamps, default: nil
    add_column :orders, :restaurant_link, :string
  end
end
