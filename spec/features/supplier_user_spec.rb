require "rails_helper"

feature "supplier visits the site" do
  before(:each) do
    @user = User.create(user_attributes({role: 1}))
    @user2 = User.create(user_attributes({fullname: "alex", email: "alex1@email.com", display_name: "alex", role: 1}))
    @supplier = Supplier.create(supplier_attributes)
    @supplier2 = Supplier.create(supplier_attributes({name: "Waterproof", slug: "waterproof"}))
    @item = @supplier.items.create(item_attributes)
    @item2 = @supplier2.items.create(item_attributes({title: "A fake item"}))
    @supplier_admin = SupplierAdmin.create( user_id: @user.id, supplier_id: @supplier.id)
    @supplier_admin2 = SupplierAdmin.create(user_id: @user2.id, supplier_id: @supplier2.id)
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

  scenario "Supplier can only view their own items" do
    allow_any_instance_of(ApplicationController).to receive(:current_user)
      .and_return(@user2)
    visit supplier_items_path(@supplier.slug)
    expect(current_path).to eq(not_found_path)
    expect(page).to have_content("Page Not Found")
  end

  scenario "Supplier can not access other suppliers items" do
    allow_any_instance_of(ApplicationController).to receive(:current_user)
      .and_return(@user)
    visit supplier_item_path(@supplier2.slug, @item2.id)
    expect(current_path).to eq(not_found_path)
    expect(page).to have_content("Page Not Found")
  end
end
