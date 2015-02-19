require "rails_helper"

feature "supplier visits the site" do
  before(:each) do
    @user = User.create(user_attributes({role: 1}))
    @supplier = Supplier.create(supplier_attributes)
    @item = @supplier.items.create(item_attributes)
    @supplier_admin = SupplierAdmin.create( user_id: @user.id, supplier_id: @supplier.id)
  end

	scenario "Supplier can visit their profile page and see their orders" do
		allow_any_instance_of(ApplicationController).to receive(:current_user)
			.and_return(@user)
		visit supplier_path(@supplier.slug)
		within('.open-orders') do
			expect(page).to have_content("Open Orders")
		end
		expect(page).to have_link("View All Orders")
		expect(page).to have_link("Manage Items")
		expect(page).to have_link("Show Account Details")
	end

	scenario "Supplier can view manage their items path" do
		allow_any_instance_of(ApplicationController).to receive(:current_user)
			.and_return(@user)
			visit supplier_path(@supplier.slug)
			first(:link, "Manage Items").click
			expect(current_path).to eq(supplier_items_path(@supplier.slug))
	end
end
