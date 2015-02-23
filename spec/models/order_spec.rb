require 'rails_helper'

RSpec.describe Order, :type => :model do
  let (:order) { Order.create(order_attributes)}
  let (:item) { Item.create(item_attributes)}

  it "is valid" do
    expect(order).to be_valid
  end

  it "is invalid without a status" do
    order.status = nil
    expect(order).to be_invalid
  end

  it "is invalid without a total" do
    order.total = nil
    expect(order).to be_invalid
  end

  it "returns an empty items array" do
    expect(order.items).to eq([])
  end

  it "responds to items" do
    expect(order).to respond_to(:items)
  end

  it { should have_many(:addresses) }
end
