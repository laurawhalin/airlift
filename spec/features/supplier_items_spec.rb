require "rails_helper"

feature "supplier items page" do
  before(:each) do
    @user = User.create(user_attributes({role: 1}))
    @supplier = Supplier.create(supplier_attributes)
		@category = Category.create(category_attributes)
    @supplier_admin = SupplierAdmin.create( user_id: @user.id, supplier_id: @supplier.id)
  end

	scenario "Supplier can create a new item" do
		allow_any_instance_of(ApplicationController).to receive(:current_user)
			.and_return(@user)
		visit supplier_items_path(@supplier.slug)
		click_link_or_button "Create New Item"
		fill_in "item[title]", with: "Battery Pack"
		fill_in "item[description]", with: "Batteries for everyone."
		fill_in "item[price]", with: 2000
		find(:css, "#category_list_categories_water[type='checkbox']").set(true)
		click_link_or_button "Save"
		expect(current_path).to eq(supplier_items_path(@supplier.slug))
		expect(page).to have_content("Battery Pack")
	end
end
