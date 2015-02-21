require "rails_helper"

feature "supplier items page" do
  before(:each) do
    @user = User.create(user_attributes({role: 1}))
    @supplier = Supplier.create(supplier_attributes)
		@category = Category.create(category_attributes)
    @supplier_admin = SupplierAdmin.create( user_id: @user.id, supplier_id: @supplier.id)
  end

	scenario "Supplier can create a new item" do
		allow_any_instance_of(ApplicationController).to receive(:current_user)
			.and_return(@user)
		visit supplier_items_path(@supplier.slug)
		click_link_or_button "Create New Item"
		fill_in "item[title]", with: "Battery Pack"
		fill_in "item[description]", with: "Batteries for everyone."
		fill_in "item[price]", with: 2000
    fill_in "item[location]", with: "Denver, CO, USA"
    fill_in "item[unit_size]", with: 10000
    fill_in "item[unit_weight]", with: 25
    find(:css, "#item_shippable[type='checkbox']").set(false)
    find(:css, "#item_available[type='checkbox']").set(false)
		find(:css, "#category_list_categories_water[type='checkbox']").set(true)
		click_link_or_button "Save"
		expect(current_path).to eq(supplier_items_path(@supplier.slug))
		expect(page).to have_content("Battery Pack")
	end

  scenario "When creating a new item, if all required info is not provided you will be directed back to page" do
    allow_any_instance_of(ApplicationController).to receive(:current_user)
      .and_return(@user)
    visit supplier_items_path(@supplier.slug)
    click_link_or_button "Create New Item"
    fill_in "item[title]", with: "Battery Pack"
    fill_in "item[description]", with: "Batteries for everyone."
    fill_in "item[price]", with: 2000
    fill_in "item[unit_size]", with: 10000
    fill_in "item[unit_weight]", with: 25
    find(:css, "#item_shippable[type='checkbox']").set(false)
    find(:css, "#item_available[type='checkbox']").set(false)
    find(:css, "#category_list_categories_water[type='checkbox']").set(true)
    click_link_or_button "Save"
    expect(current_path).to eq(supplier_items_path(@supplier.slug))
  end

  scenario "Supplier can edit an existing item" do
    item = Item.create(item_attributes(supplier_id: @supplier.id))
    allow_any_instance_of(ApplicationController).to receive(:current_user)
      .and_return(@user)
    visit supplier_items_path(@supplier.slug)
    within(".WaterPurifier") do
      click_link_or_button "Edit Item"
    end
    expect(current_path).to eq(edit_supplier_item_path(@supplier.slug, item))
    fill_in "item[title]", with: "Life Straw"
    find(:css, "#category_list_categories_water[type='checkbox']").set(true)
    click_link_or_button "Save"
    expect(current_path).to eq(supplier_items_path(@supplier.slug))
    within(".LifeStraw") do
      expect(page).to have_content("Life Straw")
    end
  end

  scenario "Supplier can retire a listing" do
    item = Item.create(item_attributes(supplier_id: @supplier.id))
    allow_any_instance_of(ApplicationController).to receive(:current_user)
      .and_return(@user)
    visit supplier_items_path(@supplier.slug)
    within(".WaterPurifier") do
      click_link_or_button "Edit Item"
    end
    find(:css, "#item_retired[type='checkbox']").set(true)
    find(:css, "#category_list_categories_water[type='checkbox']").set(true)
    click_link_or_button "Save"
    save_and_open_page
    within(".WaterPurifier") do
      expect(page).to have_content("Retired")
    end
    visit items_path
    expect(page).to_not have_css(".WaterPurifier")
  end

  scenario "supplier can view listings index but cannot add an item to the cart" do
    item = Item.create(item_attributes(supplier_id: @supplier.id))
    allow_any_instance_of(ApplicationController).to receive(:current_user)
      .and_return(@user)
    visit items_path
    within("#item-info") do
      click_link_or_button "View More Info"
      expect(page).to_not have_content("Add to Cart")
    end
    within(".modal-content") do
      expect(page).to_not have_content("Add to Cart")
    end
  end
end
