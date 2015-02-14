require "rails_helper"

feature "User Supplier Items" do
	
	scenario "User visits items index page" do
		user = User.create(user_attributes)
		item = Item.create(item_attributes)
		visit items_path 
		expect(page).to have_content("water purifier")	
	end

	scenario "User filters items by a vendor" do
		user = User.create(user_attributes)
		item1 = Item.create(item_attributes)
		item2 = Item.create(item_attributes(title: "can o beans"))
		supplier = Supplier.create(supplier_attributes)
		
		visit items_path
		within(".supplier_list") do
			find(:css, "#current_suppliers_suppliers_fireproof[value='Fireproof']").set(true)
			check('current_suppliers_suppliers_fireproof')
		end
		expect(page).to_not have_content(item2.title)
	end
end
