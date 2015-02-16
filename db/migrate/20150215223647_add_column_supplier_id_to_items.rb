class AddColumnSupplierIdToItems < ActiveRecord::Migration
  def change
		add_reference :items, :supplier, index: true
		add_foreign_key :items, :suppliers
  end
end
