require "rails_helper"

feature "unathenticated Users can see a list of items" do
  background do
    @category = Category.create(name: "Spicy", description: "Hot! Hot! Hot!")
    @item = Item.create(title: "Hot n Spicy", description: "All the hot and spicy things you can handle", price: 1000, image:"burrito_360.png")
    @itemcategory = ItemsCategory.create(item_id: 1, category_id: 1)
  end

  scenario "User can see a list of all items" do
    visit items_path
    expect(page).to have_content("Hot n Spicy")
  end

  scenario "User can see a list of all spicy items" do
    visit "/"
    click_link_or_button "Spicy"
    expect(current_path).to eq(category_path(@category))
  end


end
