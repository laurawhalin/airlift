require "rails_helper"

feature "User Supplier Items" do

	before(:each) do
		@supplier = Supplier.create(supplier_attributes)
		@supplier2 = Supplier.create(supplier_attributes(name: "nado", slug: "nado"))
		@item = @supplier.items.create(item_attributes)
		@item2 = @supplier2.items.create(item_attributes(title: "beans", supplier_id: @supplier2.id))
	end

	scenario "User visits items index page" do
		supplier = Supplier.create(supplier_attributes)
		user = User.create(user_attributes)
		item = Item.create(item_attributes(supplier_id: supplier.id))
		visit items_path
		expect(page).to have_content("Water Purifier")
	end

	scenario "User filters items by a vendor", js: true do
		visit items_path
		find(:css, "#current_suppliers_fireproof[type='checkbox']").set(true)
		expect(page).to	have_content(@item.title)
		expect(page).to_not have_content(@item2.title)
	end

	scenario "User can view item's aggregate data by clicking link" do
		supplier = Supplier.create(supplier_attributes)
		item     = supplier.items.create(item_attributes(supplier_id: supplier.id))

		visit items_path
		first(:button,"View More Info").click
		within(".WaterPurifier") do
			expect(page).to have_content("Water Purifier")
		end
	end

	scenario "User can add supplier item to cart from item index" do
		supplier = Supplier.create(supplier_attributes)
		item = supplier.items.create(item_attributes(supplier_id: supplier.id))

		visit items_path
		first(:button, "Add to Cart").click
		within("#cart") do
			expect(page).to have_content("1")
		end
	end
end
