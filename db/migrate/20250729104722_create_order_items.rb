class CreateOrderItems < ActiveRecord::Migration[8.0]
  def change
    create_table :order_items do |t|
      t.integer :quantity, null: false
      t.decimal :total_price, precision: 8, scale: 2, null: false
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.timestamps
    end

    add_check_constraint :products, "price >= 0", name: "price_check"
  end
end
