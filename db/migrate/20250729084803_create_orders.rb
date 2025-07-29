class CreateOrders < ActiveRecord::Migration[8.0]
  def up
    create_table :orders do |t|
      t.references :user, index: true, null: false
      t.decimal :total_price
      t.decimal :total_discount

      t.timestamps
    end

    execute <<~SQL
      INSERT INTO orders (user_id, total_price, total_discount, created_at, updated_at)
      SELECT user_id, total_price, discount, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP
      FROM carts
    SQL

    drop_table :carts
  end

  def down
    create_table :carts do |t|
      t.references :user, index: true, null: false
      t.decimal :price
      t.decimal :discount

      t.timestamps
    end

    execute <<~SQL
      INSERT INTO carts (user_id, price, discount, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
      SELECT user_id, total_price, total_discount, created_at, updated_at
      FROM orders
    SQL

    drop_table :orders
  end

end

