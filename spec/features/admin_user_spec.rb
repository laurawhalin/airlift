require "rails_helper"

feature "Admin User" do
  # let(:category1) { Category.create(name: "Spicy", description: "Hot! Hot! Hot!") }
  let(:category2) { Category.create(name: "Meaty", description: "Hot! Hot! Hot!") }
  let(:admin_user_attributes) { { fullname: "frank", email: "frank@aol.com", role: "admin", password: "foobar1234", password_confirmation: "foobar1234", display_name: "franky" } }
  let(:admin_user) { User.create(admin_user_attributes) }

  scenario "Admin User can see a list of Categories" do
    admin_user
    allow_any_instance_of(ApplicationController).to receive(:current_user).
    and_return(admin_user)
    visit admin_categories_path
    expect(page).to have_content("Meaty")
  end

  scenario "Admin User can create a new Category" do
    visit admin_categories_path
    click_link_or_button "Create New Category"
    expect(current_path).to eq(new_admin_category_path)
    expect(page).to have_content("New Category")
    fill_in "category[name]", with: "Veggie"
    fill_in "category[description]", with: "Non-meat items"
    click_link_or_button "Save"
    expect(current_path).to eq(admin_categories_path)
    expect(page).to have_content("Veggie")
  end

  xscenario "Admin User can edit a current Category" do
    visit admin_categories_path
    click_link_or_button "Edit Current Category"
    expect(current_path).to eq(edit_admin_category_path)
    fill_in "category[name]", with: "Veggie2"
    fill_in "category[description]", with: "Non-meaty items"
    click_link_or_button "Save"
    expect(current_path).to eq(admin_categories_path)
    expect(page).to have_content("Veggie2")
  end

  scenario "Admin can visit admin dashboard" do
    admin_user
    allow_any_instance_of(ApplicationController).to receive(:current_user).
    and_return(admin_user)
    visit "/"
    expect(page).to have_content("Admin Dashboard")
    click_link_or_button("Admin Dashboard")
    expect(current_path).to eq(admin_dashboard_index_path)
  end
end
