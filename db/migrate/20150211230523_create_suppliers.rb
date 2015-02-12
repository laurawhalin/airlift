class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :slug
      t.string :description
      t.boolean :retired
      t.string :address

      t.timestamps null: false
    end
  end
end
