class CreateSupplierAdmins < ActiveRecord::Migration
  def change
    create_table :supplier_admins do |t|
      t.references :user, index: true

      t.timestamps null: false
    end
    add_foreign_key :supplier_admins, :users
  end
end
