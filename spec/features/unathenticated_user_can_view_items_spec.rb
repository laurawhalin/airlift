require "rails_helper"

feature "unathenticated Users can see a list of items" do
  background do
    @category = Category.create(category_attributes)
    @supplier = Supplier.create(supplier_attributes)
    @item = Item.create(item_attributes)
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

  end

  scenario "User can search for an item by title match" do
    visit root_url
    fill_in "search", with: "Water"
    click_button "Search"
    expect(current_path).to eq(items_path(@items))
    expect(page).to have_content("Water Purifier")
  end

  scenario "User can search for an item by description match" do
    visit root_url
    fill_in "search", with: "purification"
    click_button "Search"
    expect(current_path).to eq(items_path(@items))
    expect(page).to have_content("Water Purifier")
  end

  scenario "User cannot visit Admin pages" do
    visit admin_categories_path
    expect(current_path).to eq(root_path)
  end
end
