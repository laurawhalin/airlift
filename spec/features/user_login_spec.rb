require "rails_helper"

feature "User login" do
  let(:protected_user_attributes) do
      { fullname: "bob",
        email: "bob@aol.com",
        role: 0,
        password: "pass",
        password_confirmation: "pass",
        display_name: "bob" }
  end

  let!(:user) { User.create(user_attributes) }
  let(:admin_user) { User.create(admin_user_attributes) }
  let(:protected_user) { User.create(protected_user_attributes) }

  scenario "User can visit the Welcome Page" do
    visit "/"
    expect(page).to have_content("Emergency Supplies")
  end

  scenario "User can sign in with correct credentials" do
    visit "/"
    first(:button, "Log In").click
    within(".login-modal") do
      fill_in "session[email]", with: "joe@gmial.com"
      fill_in "session[password]", with: "foobar1234"
      click_link_or_button "Log In"
    end
    within("#user_nav") do
      expect(page).to have_content("Welcome, Joe Guy")
    end
  end

  scenario "regular User cannot visit Admin pages" do
    visit admin_categories_path
    expect(current_path).to eq(root_path)
  end

  scenario "unregistered user cannot login" do
    visit "/"
    first(:button, "Log In").click
    within(".login-modal") do
      fill_in "session[email]", with: "XXjimbobfrank@aol.com"
      fill_in "session[password]", with: "XXfoobar1234"
      click_link_or_button "Log In"
    end
    expect(page).to have_content("Invalid login")
  end

  scenario "registered user cannot view other user information" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).
                                                  and_return(user)
    visit user_orders_path(protected_user)
    expect(page).to have_content("Page Not Found")
  end

  scenario "an admin can view registered users information" do
    order = Order.create(order_attributes)
    item = Item.create(item_attributes)
    line_item = OrdersItem.create(item_id: item.id, order_id: order.id, quantity: 2, subtotal: 1000)
    address = user.addresses.create(billing_address_attributes(order_id: order.id, user_id: user.id))
    allow_any_instance_of(ApplicationController).to receive(:current_user).
      and_return(admin_user)

    visit user_orders_path(user)
    within("#orders") do
      expect(page).to have_content("Orders")
      expect(page).to have_content("Order#")
    end
    click_link_or_button "Order#"
    expect(page).to have_content("Order Total")
    expect(current_path).to eq(user_order_path(admin_user, order))
  end
end
