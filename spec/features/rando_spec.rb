require "rails_helper"

describe "why doesnt our db work", :type => :feature do

  before(:each) do
    @supplier = Supplier.create(supplier_attributes)
    @supplier2 = Supplier.create(supplier_attributes(name: "nado", slug: "nado"))
    @item = @supplier.items.create(item_attributes)
    @item2 = @supplier2.items.create(item_attributes(title: "beans", supplier_id: @supplier2.id))
  end

  it "doesnt work for real", js: true do
    visit items_path
    find(:css, "#current_suppliers_fireproof[type='checkbox']").set(true)
    expect(page).to	have_content(@item.title)
    expect(page).to_not have_content(@item2.title)

  end
end
