require "rails_helper"

feature "Add Items to Cart" do
  background do
    @item = Item.create(
      title: "Green Burrito",
      description: "A tasty burrito for your mouth.",
      price: 800,
      image: "burrito.jpg"
    )
  end

  scenario "an item has a cart button" do
    visit items_path
    within("table") do
      expect(page).to have_button("Add to Cart")
    end
  end

  scenario "user can add item to cart" do
    visit items_path
    click_button("Add to Cart")
    within("#cart") do
      expect(page).to have_content("1")
    end
  end

  scenario "user can view their cart" do
    visit items_path
    click_button("Add to Cart")
    click_button("Add to Cart")
    click_link("2")
    save_and_open_page
    within("#table") do
      expect(page).to have_content("Qty")
      expect(page).to have_content("2")
    end
  end
end
