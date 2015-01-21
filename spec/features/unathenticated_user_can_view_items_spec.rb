require "rails_helper"

feature "unathenticated Users can see a list of items" do
  background do
  @item = Item.create(
  title: "Green Burrito",
  description: "Spicy and Lovely",
  price: 2000,
  image: nil,
  )
  end

  scenario "User can see a list of all items" do
    visit items_path
    expect(page).to have_content("Green Burrito")
  end
end
