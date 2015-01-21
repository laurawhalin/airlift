class Seed
  def initialize
    build_items
    build_category
  end

  def build_items
    item1 = Item.create(title: "Gut Buster", description: "If its in the store, it's in this burrito!", price: 1000, image:"burrito_360.png")
    item2 = Item.create(title: "Atomic Sunrise", description: "Spicy green chili, egg, and potatoe burrito.", price: 850 , image:"burrito_360.png")
    item3 = Item.create(title: "Fiesta Especial", description: "A 6 foot party sized burrito to share with your family and friends.", price: 10000, image:"burrito_360.png")
    item4 = Item.create(title: "UF burritO", description: "Monthly special. It's out of this world.", price: 689, image:"burrito_360.png")
    item5 = Item.create(title: "Smothered Dynamite", description: "Classic pork green chili smothered burrito, your choice of fillings.", price: 899, image:"burrito_360.png")
  end

  def build_category
    category1 = Category.create(name: "Vegetarian", description: "Meatless options.")
    category2 = Category.create(name: "Spicy", description: "Hot! Hot! Hot!")
    category3 = Category.create(name: "Specialty", description: "Chef's favorites.")
    category4 = Category.create(name: "Breakfast", description: "Start your day off right.")
    category5 = Category.create(name: "Sides", description: "&#192; la carte options.")
  end
end
Seed.new
