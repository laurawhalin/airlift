require "rails_helper"

feature "supplier items page" do
  before(:each) do
    @user = User.create(user_attributes({role: 1}))
    @supplier = Supplier.create(supplier_attributes)
    @item = @supplier.items.create(item_attributes)
    @supplier_admin = SupplierAdmin.create( user_id: @user.id, supplier_id: @supplier.id)
  end
	
	scenario "Supplier can create a new item" do
		allow_any_instance_of(ApplicationController).to receive(:current_user)
			.and_return(@user)
		visit supplier_items_path(@supplier.slug)
		click_link_or_button "Create New Item"
		fill_in "item[title]", with: "Battery Pack"	
	end
end
