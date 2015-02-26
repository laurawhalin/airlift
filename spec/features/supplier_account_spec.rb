require "rails_helper"

feature "Supplier account information" do
	before(:each) do
	    @supplier = Supplier.create(supplier_attributes)
	 end

	scenario "supplier can view account details" do
		visit supplier_path(@supplier.slug)
		click_link "Fireproof Account Details"
		within(".account-details") do
			expect(page).to have_content("Fireproof")
			expect(page).to have_content("Fire disaster products")
		end
	end

	xscenario "supplier can edit account details" do
		visit supplier_path(@supplier.slug)
		click_link_or_button "Fireproof Account Details"
		within(".account-details") do
			click_link_or_button "Edit"
			fill_in "supplier[name]", with: "Helping Hand Relief"
			fill_in "supplier[description]", with: "Disaster Supplies Worldwide"
			click_button "Update"
		end
		within(".account-details") do
			expect(page).to have_content("Helping Hand Relief")
			expect(page).to have_content("Disaster Supplies Worldwide")
		end
	end

	xscenario "supplier can edit administrators information" do
		user1 = User.create(user_attributes)
		supplier_admin1 = SupplierAdmin.create(supplier_admin_attributes)
		allow_any_instance_of(ApplicationController).to receive(:current_user)
			.and_return(user1)
		visit supplier_path(@supplier.slug)
		click_link "Manage Fireproof Administrators"
		first(:button, "Edit").click
		within(".reg-modal-#{user1.fullname.split.join}") do
			fill_in "user[fullname]", with: "Jason"
		first(:button, "Update").click
		end
		click_link "Manage Fireproof Administrators"
		within('.admin-details') do
			expect(page).to have_content("Jason")
		end
	end

	scenario "supplier can edit administrators role" do
		user1 = User.create(user_attributes)
		user2 = User.create(user_attributes(fullname: "chuppy", role: 1, email: "chuppy@example.com"))
		supplier_admin1 = SupplierAdmin.create(supplier_admin_attributes)
		allow_any_instance_of(ApplicationController).to receive(:current_user)
			.and_return(user1)
		supplier_admin2 = SupplierAdmin.create(supplier_admin_attributes(user_id: user2.id, supplier_id: @supplier.id))
		visit supplier_path(@supplier.slug)

		click_link "Manage Fireproof Administrators"
		first(:button, "Edit").click
		within(".reg-modal-#{user1.fullname.split.join}") do
			page.select("User", :from => "user_role")
		end
		first(:button, "Update").click
		within('.admin-details') do
			#expect(page).to_not have_content(user1.fullname)
		end
	end

	scenario "Supplier should always have one admin" do
		user1 = User.create(user_attributes)
		supplier_admin1 = SupplierAdmin.create(supplier_admin_attributes)
		allow_any_instance_of(ApplicationController).to receive(:current_user)
			.and_return(user1)
		visit supplier_path(@supplier.slug)

		click_link "Manage Fireproof Administrators"
		first(:button, "Edit").click
		within(".reg-modal-#{user1.fullname.split.join}") do
			expect(page).to_not have_css("#user_role")
		end
	end
end
