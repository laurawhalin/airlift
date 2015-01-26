require "rails_helper"

feature "Admin User Items" do
  background do
    @admin_user = User.create(fullname: "frank", email: "frank@aol.com", role: "admin",
                              password: "foobar1234", password_confirmation: "foobar1234", display_name: "franky")
  end

  scenario "User Admin can visit items index page" do
    item = Item.create(title: "food", description: "Yummy", image: "joe.jpeg")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)

    visit admin_items_path
  end

  scenario "Admin User can create new items and see them on index page" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
    visit admin_items_path
    click_link_or_button "Create New Item"
    expect(current_path).to eq(new_admin_item_path)

    fill_in "item[title]", with: "Delish"
    fill_in "item[description]", with: "It's the best"
    fill_in "item[price]", with: "1234"
    click_link_or_button "Save"
    expect(current_path).to eq(admin_items_path)
    expect(page).to have_content("Delish")
  end

  xscenario "Admin User can create item with image" do
  end
end
