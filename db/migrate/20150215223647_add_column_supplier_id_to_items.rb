class AddColumnSupplierIdToItems < ActiveRecord::Migration
  def change
		add_reference :items, :supplier, index: true
  end
end
