require "rails_helper"

RSpec.describe Category, type: :model do
  let(:category) {
    Category.new(
                 name: "burritos",
                 description: "all the burritos"
                 )
  }

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

  xit "can have many items" do
    category.items.create(
                          title: "Green Chili Burrito",
                          description: "Amazingly spicey burrito",
                          price: 655,
                          image: "image/path"
                          )
    expect(category.items.map(&:category_id)).to eq([category.id])
  end
end
