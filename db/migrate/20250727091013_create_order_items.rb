class CreateOrderItems < ActiveRecord::Migration[8.0]
  def change
    create_table :order_items do |t|
      t.integer :quantity, null: false
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end

    drop_table :cart_items
  end
end
