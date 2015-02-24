require 'rails_helper'

feature "supplier views orders" do
  before(:each) do
    @supplier = Supplier.create(supplier_attributes)
    @item = @supplier.items.create(item_attributes)
    @admin_user = User.create(admin_user_attributes)
    @user = User.create(user_attributes)
    @order = Order.create(order_attributes)
    @billing_address = @order.addresses.create(billing_address_attributes(user_id = @user.id))
    @shipping_address = @order.addresses.create(shipping_address_attributes(user_id = @user.id))
    @line_items = @item.orders_items.create(
                                           order_id: @order.id,
                                           quantity: 3,
                                           subtotal: @item.price * 3
                                          )
  end

  scenario "a supplier can view current orders list" do
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
    @billing_address.user_id = @user.id
    @billing_address.save
    @shipping_address.user_id = @user.id
    @shipping_address.save

    visit supplier_orders_path(@supplier.slug)
    click_link("Order#")
    expect(page).to have_content("Water Purifier")
    expect(page).to have_content("Relief Supplier Acme")
  end

  scenario "a supplier's order list only contains their orders", js: true do
    @billing_address.user_id = @user.id
    @shipping_address.user_id = @user.id
    supplier2 = Supplier.create(supplier_attributes)
    item2 = supplier2.items.create(item_attributes(title: "BB Gun"))
    order2 = Order.create(order_attributes)
    billing_address2 = @user.addresses.create(billing_address_attributes(order_id = order2.id))
    billing_address2.order_id = order2.id
    billing_address2.save
    shipping_address2 = @user.addresses.create(shipping_address_attributes(order_id = order2.id))
    shipping_address2.order_id = order2.id
    shipping_address2.save

    allow_any_instance_of(ApplicationController).to receive(:current_user)
      .and_return(@admin_user)
    visit supplier_orders_path(@supplier.slug)
    expect(page).to have_content("Order# #{@order.id}")
    expect(page).to_not have_content("Order# #{order2.id}")
  end

  scenario "a supplier's order details only contains their items" do
    @billing_address.user_id = @user.id
    @billing_address.save
    @shipping_address.user_id = @user.id
    @shipping_address.save
    supplier2 = Supplier.create(supplier_attributes)
    item2 = supplier2.items.create(item_attributes(title: "BB Gun"))
    order2 = Order.create(order_attributes)
    billing_address2 = @user.addresses.create(billing_address_attributes(user_id = @user.id))
    billing_address2.order_id = order2.id
    billing_address2.save
    shipping_address2 = @user.addresses.create(shipping_address_attributes(user_id = @user.id))
    shipping_address2.order_id = order2.id
    shipping_address2.save

    allow_any_instance_of(ApplicationController).to receive(:current_user)
    .and_return(@admin_user)
    visit supplier_orders_path(@supplier.slug)
    click_link("Order#")
    expect(page).to have_content("Water Purifier")
    expect(page).to_not have_content("BB Gun")
  end
end
