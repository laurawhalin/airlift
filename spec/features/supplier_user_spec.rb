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
    save_and_open_page
    within(".table")
      expect(page).to have_content(@item.title)
      expect(page).to have_
  end
end
