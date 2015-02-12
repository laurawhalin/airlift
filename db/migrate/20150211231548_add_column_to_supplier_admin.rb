class AddColumnToSupplierAdmin < ActiveRecord::Migration
  def change
    add_reference :supplier_admins, :supplier, index: true
    add_foreign_key :supplier_admins, :suppliers
  end
end
