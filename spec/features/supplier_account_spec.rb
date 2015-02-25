require "rails_helper"

feature "Supplier account information" do
	before(:each) do
	    @user = User.create(user_attributes({role: 1}))
	    @supplier = Supplier.create(supplier_attributes)
	    @supplier_admin = SupplierAdmin.create( user_id: @user.id, supplier_id: @supplier.id)
			allow_any_instance_of(ApplicationController).to receive(:current_user)
				.and_return(@user)
	 end

	scenario "supplier can view account details" do
		visit supplier_path(@supplier.slug)
		click_link "Fireproof Account Details"
		within(".account-details") do
			expect(page).to have_content("Fireproof")
			expect(page).to have_content("Fire disaster products")
		end
	end

	scenario "supplier can edit account details" do
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

	scenario "supplier can edit administrators information", :js => true do
		user2 = User.create(user_attributes({fullname: "Brandon", email: "bmrz@gmail.com", role: 1 }))
		supplier_admin2 = SupplierAdmin.create(user_id: user2.id , supplier_id: @supplier.id)
		allow_any_instance_of(ApplicationController).to receive(:current_user)
			.and_return(user2)
		visit supplier_path(@supplier.slug)
		click_link "Manage Fireproof Administrators"
		expect(page).to have_content(user2.fullname)
		first(:button, "Edit").click
		within(".reg-modal-#{@user.fullname.split.join}") do
			fill_in "user[fullname]", with: "Jason"
		end
		first(:button, "Update").click
		click_link "Manage Fireproof Administrators"
		within('.admin-details') do
			expect(page).to have_content("Jason")
		end
	end
	scenario "supplier can edit administrators role", :js => true do
		user2 = User.create(user_attributes({fullname: "Brandon", email: "bmrz@gmail.com", role: 1 }))
		supplier_admin2 = SupplierAdmin.create(user_id: user2.id , supplier_id: 1)
		allow_any_instance_of(ApplicationController).to receive(:current_user)
			.and_return(user2)
		visit supplier_path(@supplier.slug)
		click_link "Manage Fireproof Administrators"
		first(:button, "Edit").click
		within(".reg-modal-#{@user.fullname.split.join}") do
			find('#user_role').find(:xpath, 'option[1]').select_option
		end
		first(:button, "Update").click
		click_link "Manage Fireproof Administrators"
		within('.admin-details') do
			expect(page).to_not have_content(@user.fullname)
		end
	end

	scenario "Supplier should always have one admin" do
		visit supplier_path(@supplier.slug)
		click_link "Manage Fireproof Administrators"
		first(:button, "Edit").click
		within(".reg-modal-#{@user.fullname.split.join}") do
			expect(page).to_not have_css("#user_role")
		end
	end
end
