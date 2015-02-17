require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) {
    User.create(
                fullname: "Daisy",
                display_name: "lildaisy",
                email: "daisy@example.com",
                password: "password",
                role: "default"
                )
  }
  let(:default_supplier_attributes) do
    { name: "Supplier X",
      slug: "supplier-x",
      description: "A store for all of you disaster relief needs",
      retired: false,
      address: "101 William White Blvd, Pueblo, Co 80111" }
  end
  let(:supplier) { Supplier.create(default_supplier_attributes) }
  let!(:supplier_admin) { SupplierAdmin.create(user_id: user.id, supplier_id: supplier.id) }

  it "is valid" do
    expect(user).to be_valid
  end

  it "is not valid without a fullname" do
    user.fullname = nil
    expect(user).to_not be_valid
  end

  it "is not valid without an email" do
    user.email = nil
    expect(user).to_not be_valid
  end

  it "is not valid without a unique email" do
    user
    user_2 = User.new(
                      fullname: "Daisy",
                      display_name: "lildaisy",
                      email: "daisy@example.com",
                      password: "password",
                      role: "default"
                      )
    expect(user_2).to_not be_valid
  end

  it "is not valid without a password" do
    user.password = nil
    expect(user).to_not be_valid
  end

  it "is not valid without a role" do
    user.role = nil
    expect(user).to_not be_valid
  end

  it "is not valid with a display name under 2 characters" do
    user_2 = User.new(
                      fullname: "Daisy",
                      display_name: "l",
                      email: "daisy@example.com",
                      password: "password",
                      role: "default"
                      )
    expect(user_2).to_not be_valid
  end

  it "is not valid with a display name over 32 characters" do
    user_2 = User.new(
                      fullname: "Daisy",
                      display_name: "llskdjflawierlansvllaiwjekajdsfljkwelkjla",
                      email: "daisy@example.com",
                      password: "password",
                      role: "default"
                      )
    expect(user_2).to_not be_valid
  end

  it "is valid without a display name" do
    user.display_name = nil
    expect(user).to be_valid
  end

  it "can have many orders" do
    user.orders.create(status: "pending", total: "2434")
    expect(user.orders.map(&:user_id)).to eq([user.id])
  end

  it "can find it admin_supplier id" do
    expect(user.find_supplier_admin(user.id).id).to eq(18)
  end
end
