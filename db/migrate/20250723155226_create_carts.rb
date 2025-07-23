class CreateCarts < ActiveRecord::Migration[8.0]
  def change
    create_table :carts do |t|
      t.references :user
      t.decimal :total_price
      t.decimal :discount

      t.timestamps
    end
  end
end
