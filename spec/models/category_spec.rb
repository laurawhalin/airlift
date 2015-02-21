require "rails_helper"

RSpec.describe Category, type: :model do
  let(:category) { Category.create(category_attributes) }

  it "is valid" do
    expect(category).to be_valid
  end

  it "is not valid without a name" do
    category.name = nil
    expect(category).to_not be_valid
  end

  it "is not valid without a description" do
    category.description = nil
    expect(category).to_not be_valid
  end

  it "can have many items" do
    category.items.create(item_attributes)
    category.items.create(item_attributes(title: "BB Gun"))
    expect(category.items.count).to eq 2
    expect(category.items.map(&:title)).to eq(["Water Purifier",
                                               "BB Gun"])
  end

  it "is not valid with a duplicate name" do
    category1 = category
    category2 = Category.new(category_attributes)
    expect(category1).to be_valid
    expect(category2).to_not be_valid
  end
end
