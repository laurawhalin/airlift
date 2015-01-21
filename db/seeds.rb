class Seed
  def initialize
    build_items
    build_category
  end

  def build_items
    item1 = Item.create(title: "Gut Buster", description: "If its in the store, it's in this burrito!", price: 1000, image:"burrito_360.png")
    item2 = Item.create(title: "", description: "", price: , image:"burrito_360.png")

    item16 = Item.create(title: "Tamale Torpedo", description: "These little tamale bombs come in one flavor: spicy!", price: 400, image:"burrito_360.png")
    item17 = Item.create(title: "Rice and Bombs", description: "Our slow-simmered black beans and cilantro-lime rice packaged up in individual parachute packs.", price: 300, image:"burrito_360.png")
    item18 = Item.create(title: "Hot Sauce Bucket", description: "Just what it sounds like: a small bucket of our hourse hot sauce.", price: 300, image:"burrito_360.png")
    item19 = Item.create(title: "Chips and Salsa", description: "A bag of chips bubble wrapped for special delivery with a small bucket of our house hot sauce.", price: 400, image:"burrito_360.png")
    item20 = Item.create(title: "Enola Empenada", description: "This empenada is filled with our famous mushroom salsa.", price: 500, image:"burrito_360.png")
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
