require 'rails_helper'

RSpec.describe SupplierAdmin, :type => :model do
  let(:default_supplier_attributes) { {name: "Supplier X", slug: "supplier-x", description: "A store for all of you disaster relief needs", retired: false, address: "101 William White Blvd, Pueblo, Co 80111" }}
  let(:default_user_attributes) { {fullname: "user1", email: "user1@aol.com", role: 1, password: "foobar1234", password_confirmation: "foobar1234", display_name: "frankyboy" }}
  let(:supplier) { Supplier.create(default_supplier_attributes) }
  let(:user) { User.create(default_user_attributes) }
  let(:default_supplier_admin_attributes) { { supplier_id: supplier.id, user_id: user.id  } }
  let(:supplier_admin){ SupplierAdmin.create(default_supplier_admin_attributes) }

  it "is valid" do
    expect(supplier_admin).to be_valid
  end

  it "is not valid without a user" do
    supplier_admin.user_id = nil
    expect(supplier_admin).to_not be_valid
  end

  it "is not valid without a supplier" do
    supplier_admin.supplier_id = nil
    expect(supplier_admin).to_not be_valid
  end

  it "is associated with a user" do
    expect(supplier_admin.user.fullname).to eq("user1")
  end

  it "is associated with a supplier" do
    expect(supplier_admin.supplier.slug).to eq("supplier-x")
  end
end
