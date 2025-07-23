class CreateCartItems < ActiveRecord::Migration[8.0]
  def change
    create_table :cart_items do |t|
      t.integer :quantity
      t.references :product

      t.timestamps
    end
  end
end
