require "rails_helper"

feature "supplier visits the site" do
  before(:each) do
    @user = User.create(user_attributes({role: 1}))
    @supplier = Supplier.create(supplier_attributes)
    @item = @supplier.items.create(item_attributes)
    @supplier_admin = SupplierAdmin.create( user_id: @user.id, supplier_id: @supplier.id)
  end

  scenario "supplier can view listing page" do
    visit root_path
    first(:button, "Log In").click
    within(".login-modal") do
      fill_in "session[email]", with: @user.email
      fill_in "session[password]", with: @user.password
      click_link_or_button "Log In"
    end
    expect(page).to have_content(@item.title)
  end

	scenario "Supplier can visit their profile page and see their orders" do 
		allow_any_instance_of(ApplicationController).to receive(:current_user)
			.and_return(@user)
		visit supplier_path(@supplier.slug)
		within('.open-orders') do
			expect(page).to have_content("Open Orders")
		end
		expect(page).to have_link("View All Orders")
	end
end
