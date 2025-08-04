class CreateOrderItems < ActiveRecord::Migration[8.0]
  def change
    create_table :order_items do |t|
      t.integer :quantity, null: false
      t.decimal :total_price, precision: 8, scale: 2, null: false
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.timestamps
    end

    add_check_constraint :order_items, "quantity >= 0", name: "quantity_check"
    add_check_constraint :order_items, "total_price >= 0", name: "total_price_check"
    add_check_constraint :orders, "total_price >= 0", name: "total_price_check"
  end
end
