require "rails_helper"

feature "Admin User Items" do
  background do
    @admin_user = User.create(fullname: "frank", email: "frank@aol.com", role: "admin",
    password: "foobar1234", password_confirmation: "foobar1234", display_name: "franky")
    @category = Category.create(name: "Meat",
    description: "Bacon! Bacon! Bacon!")
    @item = Item.create(title: "Hot n Spicy",
    description: "All the hot and spicy things you can handle",
    price: 1000)
  end

  scenario "Admin User can edit current items and see them updated on index page" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
    visit admin_items_path
    click_link_or_button "Edit Item"
    expect(current_path).to eq(edit_admin_item_path(@item))
    fill_in "item[title]", with: "new"
    fill_in "item[description]", with: "this is it"
    fill_in "item[price]", with: "2200"
    find(:css, "#category_list_categories_meat[value='Meat']").set(true)
    click_link_or_button "Save"
    expect(current_path).to eq(admin_items_path)
    expect(page).to have_content("new")
    expect(page).to have_content("this is it")
    expect(page).to have_content("$22.00")
  end
end
