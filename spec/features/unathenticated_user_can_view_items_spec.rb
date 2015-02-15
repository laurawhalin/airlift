require "rails_helper"

feature "unathenticated Users can see a list of items" do
  background do
    @category = Category.create(name: "Baby", description: "Baby supplies.")
    @item = Item.create(title: "Formula", description: "Can of powdered baby formula", price: 1600)
    @category.items << @item
  end

  scenario "User can see a list of all items" do
    visit root_url
    click_button "View All Supplies"
    expect(page).to have_content("Formula")
  end

  scenario "user can filter the list of items by category" do
    visit items_path
    click_link "Baby"
    expect(page).to have_content("Baby Supplies")
  end

  scenario "User can search for an item by title match" do
    visit root_url
    fill_in "search", with: "Formula"
    click_button "Search"
    expect(current_path).to eq(items_path(@items))
    expect(page).to have_content("Formula")
  end

  scenario "User can search for an item by description match" do
    visit root_url
    fill_in "search", with: "baby"
    click_button "Search"
    expect(current_path).to eq(items_path(@items))
    expect(page).to have_content("baby")
  end

  scenario "User can add item to cart from category page" do
    visit category_path(@category)
    click_link_or_button "Add to Cart"
    within("#flash_notice") do
      "You have 1, Hot n Spicy in your cart."
    end
  end

  scenario "User can not visit Admin pages" do
    visit admin_categories_path
    expect(current_path).to eq(root_path)
  end
end
