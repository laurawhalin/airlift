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
    # visit items_path
    # expect(page).to have_content("Formula")
  end

  scenario "user can filter the list of items by category" do
    visit items_path
    click_link "Baby"
    expect(page).to have_content("Baby Supplies")
  end

  scenario "User can see a list of items by category" do
    visit "/"
    fill_in "search[:search_bar]", with: "Baby"
    expect(current_path).to eq(category_path(@category))
    expect(page).to have_content("Hot n Spicy")
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
