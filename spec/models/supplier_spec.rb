require 'rails_helper'

RSpec.describe Supplier, :type => :model do

  describe "Supplier" do
     it "has an item" do
        supplier = Supplier.create(supplier_attributes)
        item =  Item.create(item_attributes)
			 	supplier.items << item

        expect(supplier.items.count).to eq(1)
        expect(supplier.items.first.id).to eq(item.id)
     end

		 it "changes the slug after update of supplier name" do
			supplier = Supplier.create(supplier_attributes)
			supplier.update(name: "Newbie")

			expect(supplier.slug).to eq("newbie")
		 end

		it { should validate_presence_of(:name) }

 		it { should validate_presence_of(:description) }
  end
end
