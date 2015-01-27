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
    within("#cart_table") do
      expect(page).to have_content("Qty")
      expect(page).to have_content("$16.00")
    end
  end

  scenario "user can delete item from cart" do
    visit items_path
    click_button("Add to Cart")
    click_button("Add to Cart")
    click_link("2")
    click_button("Delete")
    within("#cart") do
      expect(page).to have_content("0")
    end
    within("#cart_table") do
      expect(page).to_not have_content("1")
      expect(page).to_not have_content("$8.00")
    end
  end

  scenario "user can update quantity of item in cart" do
    visit items_path
    click_button("Add to Cart")
    click_link("1")
    fill_in "qty", with: "2"
    click_button("Update Qty")
    within("#cart_table") do
      expect(page).to have_content("$16.00")
      expect(page).to_not have_content("$8.00")
    end
  end

  scenario "authenticated user can checkout" do
    visit items_path
    click_button("Add to Cart")
    click_link("1")
    click_button("Checkout")
    expect(current_path).to eq(user_order_path)
    within("checkout") do
      expect(page).to have_content("Thank you for your order!")
      expect(page).to have_css("video blah blah")
    end
  end
end
