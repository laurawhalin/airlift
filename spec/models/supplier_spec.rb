require 'rails_helper'

RSpec.describe Supplier, :type => :model do
  
  it "has an item" do
    supplier = Supplier.create(supplier_attributes)
    supplier = supplier.item.create(item_attributes)
    
  
end
