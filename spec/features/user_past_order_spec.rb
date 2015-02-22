require "rails_helper"

feature "Past Orders" do

  xscenario "a user can view his orders" do
    user = User.create(user_attributes)
    order = Order.create(order_attributes)
    item = Item.create(item_attributes)
    line_item = OrdersItem.create(item_id: item.id, order_id: order.id, quantity: 2, subtotal: 1000)

    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                          and_return(user)
    visit user_orders_path(user)
    within("#orders") do
      expect(page).to have_content("Orders")
      expect(page).to have_content("Order#")
    end

    click_link_or_button "Order#"
    expect(page).to have_content("Order Total")
    expect(current_path).to eq(user_order_path(user, order))
  end
end
