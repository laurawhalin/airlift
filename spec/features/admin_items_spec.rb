require "rails_helper"

feature "Admin User Items" do
  background do
    @supplier = Supplier.create(supplier_attributes)
    @admin_user = User.create(admin_user_attributes)
    @supplier_admin = SupplierAdmin.create(supplier_id: @supplier.id, user_id: @admin_user.id)
    @category = Category.create(category_attributes)
    @item = Item.create(item_attributes)
    @slug = @supplier.slug
  end

  scenario "User Admin can visit items index page" do
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@admin_user)
    visit supplier_items_path(@slug)
    expect(page).to have_content("Water Filter")
  end

  xscenario "Admin User can create new items and see them on index page" do
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@admin_user)
    visit supplier_items_path(@slug)
    save_and_open_page
    click_link_or_button "Create New Item"
    expect(current_path).to eq(new_supplier_item_path(@slug))
    fill_in "item[title]", with: "BB Gun"
    fill_in "item[description]", with: "For fending off zombie squirrels."
    fill_in "item[price]", with: "7234"
    find(:css, "#WaterID[type='checkbox']").set(true)
    click_link_or_button "Save"
    expect(current_path).to eq(supplier_items_path(@slug))
    expect(page).to have_content("BB Gun")
  end

  xscenario "Admin User can create new item and assign to a category" do
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@admin_user)
    visit supplier_items_path(@slug)
    click_link_or_button "Create New Item"
    fill_in "item[title]", with: "BB Gun"
    fill_in "item[description]", with: "For fending off zombie squirrels."
    fill_in "item[price]", with: "7234"
    find(:css, "#category_list_categories_water[value='Water']").set(true)
    click_link_or_button "Save"
    expect(current_path).to eq(supplier_items_path(@slug))
    visit items_path
    find(:css, "#WaterID[type='checkbox']").set(true)
    expect(page).to have_content("BB Gun")
  end

  xscenario "Admin User can edit items and see them updated on index page" do
    allow_any_instance_of(ApplicationController).
    to receive(:current_user).and_return(@admin_user)
    visit supplier_items_path(@slug)
    click_link_or_button "Edit Item"
    expect(current_path).to eq(edit_supplier_item_path(@slug, @item))
    fill_in "item[title]", with: "new"
    fill_in "item[description]", with: "this is it"
    fill_in "item[price]", with: "2200"
    click_link_or_button "Save"
    expect(current_path).to eq(supplier_items_path(@slug))
    expect(page).to have_content("new")
    expect(page).to have_content("this is it")
    expect(page).to have_content("$22.00")
  end

  xscenario "Admin User can edit an item and reassign it to a category" do
    allow_any_instance_of(ApplicationController).
      to receive(:current_user).and_return(@admin_user)
    visit supplier_items_path(@slug)
    click_link_or_button "Edit Item"
    fill_in "item[title]", with: "BB Gun"
    fill_in "item[description]", with: "For fending off zombie squirrels."
    fill_in "item[price]", with: "7234"
    find(:css, "#WaterID[type='checkbox']").set(true)
    click_link_or_button "Save"
    expect(current_path).to eq(supplier_items_path(@slug))
    visit items_path
    find(:css, "#WaterID[type='checkbox']").set(true)
    expect(page).to have_content("BB Gun")
  end

  xscenario "Admin User can change item status to retired and check views" do
    allow_any_instance_of(ApplicationController).
    to receive(:current_user).and_return(@admin_user)
    visit supplier_items_path(@slug)
    click_link_or_button "Edit Item"
    fill_in "item[title]", with: "BB Gun"
    fill_in "item[description]", with: "For fending off zombie squirrels."
    fill_in "item[price]", with: "7234"
    find(:css, "#WaterID[type='checkbox']").set(true)
    find(:css, "#item_retired[value='1']").set(true)
    click_link_or_button "Save"
    expect(current_path).to eq(supplier_items_path(@slug))
    expect(page).to have_content("For fending off zombie squirrels.")
    visit items_path
    find(:css, "#WaterID[type='checkbox']").set(true)
    expect(page).to_not have_content("BB Gun")
  end
end
