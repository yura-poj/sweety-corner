class CreateCartItems < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_items do |t|
      t.integer :quantity, null: false
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
