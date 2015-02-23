class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :line_one
      t.string :line_two
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :country
      t.string :address_type
      t.references :user, index: true
      t.references :order, index: true

      t.timestamps null: false
    end
  end
end
