class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.text :description
      t.decimal :price, null: false
      t.decimal :discount, null: false, default: 0
      t.integer :available_quantity, null: false
      t.timestamps
    end
  end
end
