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
end
