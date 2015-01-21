class Seed
  def initialize
    build_items
    build_category
  end

  def build_items
    item1 = Item.create(title: "Gut Buster", description: "If its in the store, it's in this burrito!", price: 1000, image:"burrito_360.png")
    item11 = Item.create(title: "Halo", description: "All fresh vegetables which gives you the moring shine", price: 500, image:"burrito_360.png")
    item12 = Item.create(title: "Vegi delight", description: "Eat all your vegies, tomatoes, red onions, green pepers, mushrooms and more)", price: 700, image:"burrito_360.png")
    item13 = Item.create(title: "Not too Sweet", description: "Just enough to satisfy for sweet quench, all sweet things", price: 500, image:"burrito_360.png")
    item14 = Item.create(title: "Classic", description: "Our same classic burrito with it's authentic flavors", price: 800, image:"burrito_360.png")
    item15 = Item.create(title: "Hot n Spicy", description: "All the hot and spicy things you can handle", price: 1000, image:"burrito_360.png")
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
