require "rails_helper"

feature "Admin User Items" do
  background do
    @admin_user = User.create(fullname: "frank",
                              email: "frank@aol.com",
                              role: "admin",
                              password: "foobar1234",
                              password_confirmation: "foobar1234",
                              display_name: "franky")
    @category = Category.create(name: "Meat",
                                description: "Bacon! Bacon! Bacon!")
    @item = Item.create(title: "Hot n Spicy",
                        description: "All the hot and spicy things",
                        price: 1000)
  end

  scenario "User Admin can visit items index page" do
    Item.create(title: "food", description: "Yummy")
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@admin_user)

    visit admin_items_path
  end

  scenario "Admin User can create new items and see them on index page" do
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@admin_user)
    visit admin_items_path
    click_link_or_button "Create New Item"
    expect(current_path).to eq(new_admin_item_path)
    fill_in "item[title]", with: "Delish"
    fill_in "item[description]", with: "It's the best"
    fill_in "item[price]", with: "1234"
    find(:css, "#category_list_categories_meat[value='Meat']").set(true)
    click_link_or_button "Save"
    expect(current_path).to eq(admin_items_path)
    expect(page).to have_content("Delish")
  end

  scenario "Admin User can create new item and assign to a category" do
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@admin_user)
    visit admin_items_path
    click_link_or_button "Create New Item"
    fill_in "item[title]", with: "Delish"
    fill_in "item[description]", with: "It's the best"
    fill_in "item[price]", with: "1234"
    find(:css, "#category_list_categories_meat[value='Meat']").set(true)
    click_link_or_button "Save"
    expect(current_path).to eq(admin_items_path)
    click_link "Meat"
    expect(page).to have_content("Delish")
  end

  scenario "Admin User can edit an item and reassign it to a category" do
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@admin_user)
    visit admin_items_path
    click_link_or_button "Edit Item"
    fill_in "item[title]", with: "Hot n Spicy"
    fill_in "item[description]", with: "It's the best"
    fill_in "item[price]", with: "1234"
    find(:css, "#category_list_categories_meat[value='Meat']").set(true)
    click_link_or_button "Save"
    expect(current_path).to eq(admin_items_path)
    click_link "Meat"
    save_and_open_page
    expect(page).to have_content("It's the best")
  end
end
