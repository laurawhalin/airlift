class AddColumnToSupplierAdmin < ActiveRecord::Migration
  def change
    add_reference :supplier_admins, :supplier, index: true
  end
end
