require "rails_helper"

feature "Supplier Login" do
  let(:default_supplier_attributes) do
      { name: "Supplier X",
        slug: "supplier-x",
        description: "A store for all of you disaster relief needs",
        retired: false,
        address: "101 William White Blvd, Pueblo, Co 80111" }
  end
  let(:default_user_attributes) do
      { fullname: "user1",
        email: "user1@aol.com",
        role: 1,
        password: "foobar1234",
        password_confirmation: "foobar1234",
        display_name: "frankyboy" }
  end
  let(:supplier) { Supplier.create(default_supplier_attributes) }
  let(:user) { User.create(default_user_attributes) }
  let(:default_supplier_admin_attributes) do
    { supplier_id: supplier.id, user_id: user.id  }
  end
  let!(:supplier_admin) do
    SupplierAdmin.create(default_supplier_admin_attributes)
  end

  scenario "Supplier admin can log In" do
    visit root_path
    first(:button, "Log In").click
    within(".login-modal") do
      fill_in "session[email]", with: user.email
      fill_in "session[password]", with: user.password
      click_link_or_button "Log In"
    end
    expect(current_path).to eq(supplier_path(supplier.slug))
    within("#supplier_home") do
      expect(page).to have_content("Supplier X Supplier Page")
    end
  end
end
