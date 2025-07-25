class CreateCarts < ActiveRecord::Migration[8.0]
  def change
    create_table :carts do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total_price, null: false
      t.decimal :discount, null: false, default: 0

      t.timestamps
    end
  end
end
