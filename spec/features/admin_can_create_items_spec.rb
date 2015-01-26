require "rails_helper"

feature "Admin User" do
  background do
  end
  scenario "User Admin can see a list of items" do
    @item = Item.create(title: "The big one", description: "Yummy", image: "joe.jpeg")
    allow_any_instance_of(ApplicationController).to receive(:current_user)
                                              .and_return(@admin_user)
    visit admin_items_path
    expect(page).to have_content("The big one")
  end

  scenario "Admin User can create new items" do
    allow_any_instance_of(ApplicatonController).to receive(:current_user)
    .and_return(@admin_user)
    visit admin_items_path
    click_link_or_button "Create New Item"
    expect(current_path).to eq(new_admin_item_path)

    fill_in "item[title]", with: "Delish"
    fill_in "item[description]", with: "It's the best"
    click_link_or_button "Save"
    expect(current_path).to eq(admin_items_path)
    expect(page).to have_content("Delish")
  end

  xscenario "Admin User can create item with image" do
  end
end
