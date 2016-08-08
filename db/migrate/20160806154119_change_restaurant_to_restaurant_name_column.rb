class ChangeRestaurantToRestaurantNameColumn < ActiveRecord::Migration
  def change
    rename_column :orders, :restaurant, :restaurant_name
  end
end
