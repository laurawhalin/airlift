require "rails_helper"

feature "unathenticated users can see a list of items" do
  background do
    @supplier = Supplier.create(supplier_attributes)
    @category = Category.create(category_attributes)
    @item = Item.create(item_attributes(supplier_id: @supplier.id))
    @category.items << @item
  end

  scenario "User can see a list of all items" do
    visit root_url
    click_link "View All Supplies"
    expect(page).to have_content("Water Purifier")
  end

  scenario "user can filter the list of items by category" do
    visit items_path
    find(:css, "#WaterID[type='checkbox']").set(true)
    expect(page).to have_content("Water Purifier")
  end

  scenario "user can filter the list of items by multiple categories" do
    @category2 = Category.create(name: "Supplies", description: "Things you'll need.")
    @item2 = Item.create(title: "BB Gun", description: "For fending off zombie squirrels.", price: 7000, supplier_id: @supplier.id)
    visit items_path
    find(:css, "#WaterID[type='checkbox']").set(true)
    find(:css, "#SuppliesID[type='checkbox']").set(true)
    expect(page).to have_content("Water Purifier")
    expect(page).to have_content("BB Gun")
  end

  scenario "User can search for an item by title match" do
    visit root_url
    fill_in "search", with: "Purifier"
    click_button "Search"
    expect(current_path).to eq(items_path(@items))
    expect(page).to have_content("Water Purifier")
  end

  scenario "user can search for a second item from entire list" do
    @item2 = Item.create(title: "BB Gun", description: "For fending off zombie squirrels.", price: 7000, supplier_id: @supplier.id)
    visit root_url
    fill_in "search", with: "Water"
    click_button "Search"
    expect(page).to_not have_content("BB Gun")
    fill_in "search", with: "BB Gun"
    click_button "Search"
    expect(page).to have_content("BB Gun")
  end

  scenario "User can search for an item by description match" do
    visit root_url
    fill_in "search", with: "purification"
    click_button "Search"
    expect(current_path).to eq(items_path(@items))
    expect(page).to have_content("Water Purifier")
  end

  scenario "searching for items is case indifferent" do
    visit items_path
    fill_in "search", with: "purifier"
    click_button "Search"
    expect(page).to have_content("Purifier")
  end
end
