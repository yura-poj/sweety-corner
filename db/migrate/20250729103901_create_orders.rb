class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :user, index: true, null: false
      t.decimal :total_price, precision: 10, scale: 2, null: false
      t.decimal :discount, null: false

      t.timestamps
    end
  end
end
