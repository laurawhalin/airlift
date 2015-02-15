class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.references :item, index: true
      t.references :supplier, index: true
      t.integer :quantity

      t.timestamps null: false
    end
    add_foreign_key :listings, :items
    add_foreign_key :listings, :suppliers
  end
end
