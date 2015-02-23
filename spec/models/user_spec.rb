require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) { User.create(user_attributes) }
  let(:supplier) { Supplier.create(supplier_attributes) }
  let!(:supplier_admin) { supplier.supplier_admins.create(supplier_admin_attributes(user_id: user.id)) }

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
    user_2 = User.new(user_attributes)
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

  it { should have_many(:orders).through(:addresses) }

  it "can find its supplier_admin id" do
    expect(user.find_supplier_admin(user.id).id).to eq(supplier_admin.id)
  end

  it { should have_many(:addresses) }
end
