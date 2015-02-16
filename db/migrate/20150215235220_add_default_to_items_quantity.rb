class AddDefaultToItemsQuantity < ActiveRecord::Migration
	def up
	  change_column :items, :quantity, :integer, :default => 0 
	end
	
	def down
	  change_column :items, :quantity, :integer, :default => nil
	end
end
