require 'rails_helper'

RSpec.describe Supplier, :type => :model do

  describe "Supplier" do
     it "has an item" do
        supplier = Supplier.create(supplier_attributes)
        item = Item.create(item_attributes)
        supplier.listings.create(item_id: item.id, quantity: 5)

        expect(supplier.listings.count).to eq(1)
        expect(supplier.listings.first.item_id).to eq(38)
     end
  end
end
