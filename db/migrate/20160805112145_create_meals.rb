class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :name
      t.decimal :price, precision: 5, scale: 2
      t.integer :client_id, index: true
      t.integer :order_id, index: true
    end
  end
end
