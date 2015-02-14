require "rails_helper"

feature "User Supplier Items" do
	
	scenario "User visits items index page" do
		user = User.create(user_attributes)
		item = Item.create(item_attributes)
		visit items_path 
		expect(page).to have_content("water purifier")	
	end

	scenario "User filters items by a vendor" do
		item1 = Item.create(item_attributes)
		supplier = Supplier.create(supplier_attributes)
		supplier.listings.create(
														 item_id: item1.id, 
														 supplier_id: supplier.id, 
														 quantity: 500
														)	
		visit items_path
		within(".supplier_list") do
			find_link("Fireproof").visible?
		end

		click_link_or_button("Fireproof")
		expect(page).to	have_content(item1.title)
	end

	scenario "User can view item's aggregate data by clicking link" do

	end
end
