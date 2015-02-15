require "rails_helper"

feature "Supplier Login" do
  let(:default_supplier_attributes) do
      { name: "Supplier X",
        slug: "supplier-x",
        description: "A store for all of you disaster relief needs",
        retired: false,
        address: "101 William White Blvd, Pueblo, Co 80111" }
  end
  let(:supplier) { Supplier.create(default_supplier_attributes) }
  let(:default_user_attributes) do
      { fullname: "user1",
        email: "user1@aol.com",
        role: 1,
        password: "foobar1234",
        password_confirmation: "foobar1234",
        display_name: "frankyboy" }
  end
  let(:user) { User.create(default_user_attributes) }
  let(:second_user_attributes) do
      { fullname: "user2",
        email: "user2@aol.com",
        role: 0,
        password: "foobar",
        password_confirmation: "foobar",
        display_name: "user2" }
  end
  let(:user2) { User.create(second_user_attributes) }
  let(:third_user_attributes) do
    { fullname: "user3",
      email: "user3@aol.com",
      role: 1,
      password: "1234",
      password_confirmation: "1234",
      display_name: "user3" }
    end
    let(:user3) { User.create(third_user_attributes) }
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

  scenario "A user who is not a supplier cannot log into access a suppliers page" do
    visit root_path
    first(:button, "Log In").click
    within(".login-modal") do
      fill_in "session[email]", with: user2.email
      fill_in "session[password]", with: user2.password
      click_link_or_button "Log In"
    end
    expect(current_path).to eq(root_path)
    expect(page).to_not have_content("Supplier Page")
  end

  scenario "A user with a role of supplier who is a supplier admin cannot visit the suppliers page" do
    visit root_path
    first(:button, "Log In").click
    within(".login-modal") do
      fill_in "session[email]", with: user3.email
      fill_in "session[password]", with: user3.password
      click_link_or_button "Log In"
    end
    expect(current_path).to eq(root_path)
    within("#flash_errors") do
      expect(page).to have_content("User account not connected to supplier account, please contact system admin")
    end
  end
end
