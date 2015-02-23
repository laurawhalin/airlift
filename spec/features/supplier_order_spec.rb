require 'rails_helper'

feature "supplier views orders" do
  before(:each) do
    @supplier = Supplier.create(supplier_attributes)
    @item = @supplier.items.create(item_attributes)
    @admin_user = User.create(admin_user_attributes)
    @user = User.create(user_attributes)
    @cart = { @item.id => 3 }
    @order = Order.create(order_attributes)
    @billing_address = @user.addresses.create(billing_address_attributes(order_id = @order.id))
    @shipping_address = @user.addresses.create(shipping_address_attributes(order_id = @order.id))
    @line_items = @item.orders_items.create(
                                           order_id: @order.id,
                                           quantity: 3,
                                           subtotal: @item.price * 3
                                          )
  end

  scenario "a supplier can view current order" do
   	allow_any_instance_of(ApplicationController).to receive(:current_user)
			.and_return(@admin_user)
		visit supplier_path(@supplier.slug)
    click_link("View All Orders")
    expect(page).to have_content("Order# #{@order.id}")
  end

  scenario "a supplier can mark an order as shipped", js: true do
    allow_any_instance_of(ApplicationController).to receive(:current_user)
      .and_return(@admin_user)
    visit supplier_orders_path(@supplier.slug)
    first(:button, "Mark as Shipped").click
    expect(page).to_not have_content("Order# #{@order.id}")
    click_link_or_button("Shipped")
    expect(page).to have_content("Order# #{@order.id}")
  end

  scenario "a supplier can cancel an order", js: true do
    allow_any_instance_of(ApplicationController).to receive(:current_user)
      .and_return(@admin_user)
    visit supplier_orders_path(@supplier.slug)
    first(:button, "Cancel Order").click
    expect(page).to_not have_content("Order# #{@order.id}")
    click_link_or_button("Cancelled")
    expect(page).to have_content("Order# #{@order.id}")
  end

  scenario "a supplier can view the details of an order" do
    allow_any_instance_of(ApplicationController).to receive(:current_user)
      .and_return(@admin_user)
    @billing_address.order_id = @order.id
    @billing_address.save
    @shipping_address.order_id = @order.id
    @shipping_address.save

    visit supplier_orders_path(@supplier.slug)
    click_link("Order#")
    expect(page).to have_content("Water Purifier")
    expect(page).to have_content("Relief Supplier Acme")
  end
end
