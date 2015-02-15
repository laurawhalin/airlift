require 'rails_helper'

RSpec.describe Supplier, :type => :model do

  describe "Supplier" do
     it "has an item" do
        supplier = Supplier.create(supplier_attributes)
        item =  Item.create(item_attributes)
			 	supplier.items << item

        expect(supplier.items.count).to eq(1)
        expect(supplier.items.first.id).to eq(40)
     end
  end
end
