class Seed
  def initialize
    build_items
    build_category
    #build_orders
    build_users
    build_items_category
    build_supplier
    build_supplier_admin
  end

  def build_orders
    Order.create(user_id: 1, status: "ordered", total: 2000)
    OrdersItem.create(item_id: 1, order_id: 1, quantity: 2, subtotal: 2000)

    Order.create(user_id: 2, status: "ordered", total: 1500)
    OrdersItem.create(item_id: 1, order_id: 2, quantity: 1, subtotal: 1000)
    OrdersItem.create(item_id: 6, order_id: 2, quantity: 1, subtotal: 500)

    Order.create(user_id: 3, status: "completed", total: 1000)
    OrdersItem.create(item_id: 6, order_id: 3, quantity: 2, subtotal: 1000)

    Order.create(user_id: 4, status: "completed", total: 3400)
    OrdersItem.create(item_id: 1, order_id: 4, quantity: 1, subtotal: 1000)
    OrdersItem.create(item_id: 6, order_id: 4, quantity: 2, subtotal: 1000)
    OrdersItem.create(item_id: 12, order_id: 4, quantity: 2, subtotal: 1400)

    Order.create(user_id: 6, status: "paid", total: 1700)
    OrdersItem.create(item_id: 11, order_id: 5, quantity: 1, subtotal: 500)
    OrdersItem.create(item_id: 9, order_id: 5, quantity: 1, subtotal: 1200)

    Order.create(user_id: 7, status: "paid", total: 600)
    OrdersItem.create(item_id: 17, order_id: 6, quantity: 2, subtotal: 600)

    Order.create(user_id: 8, status: "cancelled", total: 700)
    OrdersItem.create(item_id: 18, order_id: 7, quantity: 1, subtotal: 300)
    OrdersItem.create(item_id: 19, order_id: 7, quantity: 1, subtotal: 400)

    Order.create(user_id: 9, status: "cancelled", total: 1000)
    OrdersItem.create(item_id: 20, order_id: 8, quantity: 2, subtotal: 1000)

    Order.create(user_id: 1, status: "completed", total: 2000)
    OrdersItem.create(item_id: 1, order_id: 9, quantity: 2, subtotal: 2000)

    Order.create(user_id: 2, status: "completed", total: 1100)
    OrdersItem.create(item_id: 7, order_id: 10, quantity: 2, subtotal: 1100)
  end


  def build_items
    filenames = Dir.glob("app/assets/images/*")
    rand_image = filenames.shuffle.first
    Item.create(title: "Canteen", description: "It holds the water for you", price: 1000, image: open("app/assets/images/canteen.jpg"), supplier_id: 1)
    Item.create(title: "Water", description: "Just water to drink", price: 850, image: open("app/assets/images/water.jpg"), supplier_id: 1)
    Item.create(title: "Water Purifier", description: "Purfiy your water", price: 8000, image:open("app/assets/images/water_purifier.jpg"), supplier_id: 2)
    Item.create(title: "Water Tablets", description: "Great way to purify small amounts of water", price: 689, image: open("app/assets/images/water_tablets.jpg"), supplier_id: 2)
    Item.create(title: "Water-Beans", description: "Just imagine this was a can of water", price: 899, image: open("app/assets/images/beans.jpg"), supplier_id: 3)
    Item.create(title: "Beans", description: "Yummy Beans", price: 500, image: open("app/assets/images/beans.jpg"), supplier_id: 3)
    Item.create(title: "Baby Formula", description: "Food for babies", price: 550, image: open("app/assets/images/formula.jpg"), supplier_id: 4)
    Item.create(title: "Soup", description: "Canned Soup", price: 750, image: open("app/assets/images/soup.jpg"), supplier_id: 4)
    Item.create(title: "Tuna", description: "Chicken of the sea", price: 1200, image: open("app/assets/images/tuna.jpg"), supplier_id: 5)
    Item.create(title: "More beans", description: "So many beans!!!", price: 650, image: open("app/assets/images/beans.jpg"), supplier_id: 5)
    300.times do
      Item.create(title: Faker::Commerce.product_name, description: Faker::Commerce.department, price: "#{rand(1...500)}", image: open("#{rand_image}"))
    end
  end

  def build_items_category
    ItemsCategory.create(item_id: 1, category_id: 3)
    ItemsCategory.create(item_id: 2, category_id: 2)
    ItemsCategory.create(item_id: 3, category_id: 3)
    ItemsCategory.create(item_id: 4, category_id: 3)
    ItemsCategory.create(item_id: 5, category_id: 2)
    ItemsCategory.create(item_id: 6, category_id: 4)
    ItemsCategory.create(item_id: 7, category_id: 5)
    ItemsCategory.create(item_id: 8, category_id: 1)
    ItemsCategory.create(item_id: 9, category_id: 5)
    ItemsCategory.create(item_id: 10, category_id: 1)
  end

  def build_category
    Category.create(name: "Power", description: "Power Supplies")
    Category.create(name: "Clothes", description: "Clothing")
    Category.create(name: "Food", description: "Food options")
    Category.create(name: "Communications", description: "Communicate clearly")
  end


  def build_users
    User.create(fullname: "Johnny Bravo", email: "hooaa@gmail.com", display_name: "jbravo", password: "password", role: 0)
    User.create(fullname: "Rachel Warbelow", email: "demo+rachel@jumpstartlab.com", password: "password", role: 0)
    User.create(fullname: "Jeff Casmir", email: "demo+jeff@jumpstartlab.com", display_name: "j3", password: "password", role: 0)
    User.create(fullname: "Jeorge Tellez", email: "demo+jorge@jumpstartlab.com", display_name: "novohispano", password: "password", role: 0)
    User.create(fullname: "Josh Cheek", email: "demo+josh@jumpstartlab.com", display_name: "josh", password: "password", role: 2, image: "cheeky.jpg")
    User.create(fullname: "Steve Kinney", email: "demo+steve@jumpstartlab.com", display_name: "steveo", password: "password", role: 0)
    User.create(fullname: "Horace Williams", email: "demo+horace@jumpstartlab.com", display_name: "horace", password: "password", role: 0)
    User.create(fullname: "Raissa Shafer", email: "demo+raissa@jumpstartlab.com", password: "password", role: 0)
    User.create(fullname: "Josh Mejia", email: "demo+jmeija@jumpstartlab.com", display_name: "meija", password: "password", role: 0)
    User.create(fullname: "Joe Blow", email: "joe@gmail.com", display_name: "joe", password: "joe", role: 1, image: "joe_blow.jpg")
    
    20.times do
      User.create(fullname: Faker::Name.name, email: Faker::Internet.email, display_name: Faker::Internet.user_name, password: "password", role: 1)
    end

    70.times do
      User.create(fullname: Faker::Name.name, email: Faker::Internet.email, display_name: Faker::Internet.user_name, password: "password", role: 0)
    end
  end

  def build_supplier_admin
    SupplierAdmin.create(user_id: 11, supplier_id: 1)
    SupplierAdmin.create(user_id: 12, supplier_id: 1)
    SupplierAdmin.create(user_id: 13, supplier_id: 2)
    SupplierAdmin.create(user_id: 14, supplier_id: 2)
    SupplierAdmin.create(user_id: 15, supplier_id: 3)
    SupplierAdmin.create(user_id: 16, supplier_id: 3)
    SupplierAdmin.create(user_id: 17, supplier_id: 4)
    SupplierAdmin.create(user_id: 18, supplier_id: 4)
    SupplierAdmin.create(user_id: 19, supplier_id: 5)
    SupplierAdmin.create(user_id: 20, supplier_id: 5)
    SupplierAdmin.create(user_id: 21, supplier_id: 6)
    SupplierAdmin.create(user_id: 22, supplier_id: 6)
    SupplierAdmin.create(user_id: 23, supplier_id: 7)
    SupplierAdmin.create(user_id: 24, supplier_id: 7)
    SupplierAdmin.create(user_id: 25, supplier_id: 8)
    SupplierAdmin.create(user_id: 26, supplier_id: 8)
    SupplierAdmin.create(user_id: 27, supplier_id: 9)
    SupplierAdmin.create(user_id: 28, supplier_id: 9)
    SupplierAdmin.create(user_id: 29, supplier_id: 10)
    SupplierAdmin.create(user_id: 30, supplier_id: 10)
  end

  def build_supplier
    Supplier.create(name: "Joe's big warehouse", slug: "joe-s-big-warehouse", description: "the best", retired: false, address: "1510 blake St. , CO" )
    Supplier.create(name: "Get Relief Now", slug: "get-relief-now", description: "one stop shop for emergency supplies", retired: false, address: "2020 blake St. , ME " )
    Supplier.create(name: "Big Supplies", slug: "big-supplies", description: "oversized supplies", retired: false, address: "2000 lake St. , IL " )
    Supplier.create(name: "Mike's Surplus", slug: "mike-s-surplus", description: "retired military supplies", retired: false, address: "13500 State St. , OR " )
    Supplier.create(name: "Big Bob's extras", slug: "big-bob-s-extras", description: "Extra stuff i found", retired: false, address: "69343 Blake St. , CA " )
    Supplier.create(name: "Turing Support", slug: "turing-support", description: "Support by the most amazing techs", retired: false, address: "1510 Blake St. , OR " )
    Supplier.create(name: "Batmans Help", slug: "batmans-help", description: "extra bat supplies", retired: false, address: "Cave somewhere, GO " )
    Supplier.create(name: "Home Depot Rejects", slug: "home-depot-rejects", description: "The stuff we cant sell to anyone else", retired: false, address: "79030 Hagle Rd. , GA " )
    Supplier.create(name: "To the Rescue", slug: "to-the-rescue", description: "Supplies for those in need.", retired: false, address: "20 bake St. , CA " )
    Supplier.create(name: "Band-Aid", slug: "band-aid", description: "temporary solutions for big problems", retired: false, address: "2 baker St. , NY " )
  end
end

Seed.new
