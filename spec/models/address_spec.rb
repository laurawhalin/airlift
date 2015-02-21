require 'rails_helper'

RSpec.describe Address, :type => :model do

  let (:user) { User.create(user_attributes) }
  let (:order) { Order.create(order_attributes)}
  let (:shipping_address) { order.addresses.create(shipping_address_attributes) }

  it "is valid" do
    expect(shipping_address).to be_valid
  end

  it {should validate_presence_of(:line_one) }
  it {should validate_presence_of(:city) }
  it {should validate_presence_of(:state) }
  it {should validate_presence_of(:postal_code) }
  it {should validate_presence_of(:country) }
  it {should validate_presence_of(:address_type) }
  it {should validate_presence_of(:user_id) }
  it {should validate_presence_of(:order_id) }

  it { should belong_to(:user) }
  it { should belong_to(:order) }
end
