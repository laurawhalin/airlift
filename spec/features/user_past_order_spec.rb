require "rails_helper"

feature "Past Orders" do
  let(:user) { User.create(fullname: "Jeff Casmir", email: "demo+jeff@jumpstartlab.com", display_name: "j3", password: "password", role: 0)}
  let(:order) { Order.create(user_id: user.id, status: "completed", total: 1000)}
  let(:item) { Item.create(title: "Two Torpedo Tacos", description: "Two crispy chicken tacos.", price: 500, image:"torpedo_tacos.png")}
  let(:order1_item1) { OrdersItem.create(item_id: item.id, order_id: order.id, quantity: 2, subtotal: 1000)}


  scenario "a user can view his orders" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                          and_return(user)
    visit user_orders_path(user)
    within("#banner") do
      expect(page).to have_content("Orders")
    end
  end
end
