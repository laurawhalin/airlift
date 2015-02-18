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
    order1 = Order.create(user_id: 1, status: "ordered", total: 2000)
    order1_item1 = OrdersItem.create(item_id: 1, order_id: 1, quantity: 2, subtotal: 2000)

    order2 = Order.create(user_id: 2, status: "ordered", total: 1500)
    order2_item1 = OrdersItem.create(item_id: 1, order_id: 2, quantity: 1, subtotal: 1000)
    order2_item6 = OrdersItem.create(item_id: 6, order_id: 2, quantity: 1, subtotal: 500)

    order3 = Order.create(user_id: 3, status: "completed", total: 1000)
    order3_item6 = OrdersItem.create(item_id: 6, order_id: 3, quantity: 2, subtotal: 1000)

    order4 = Order.create(user_id: 4, status: "completed", total: 3400)
    order4_item1 = OrdersItem.create(item_id: 1, order_id: 4, quantity: 1, subtotal: 1000)
    order4_item6 = OrdersItem.create(item_id: 6, order_id: 4, quantity: 2, subtotal: 1000)
    order4_item12 = OrdersItem.create(item_id: 12, order_id: 4, quantity: 2, subtotal: 1400)

    order5 = Order.create(user_id: 6, status: "paid", total: 1700)
    order5_item1 = OrdersItem.create(item_id: 11, order_id: 5, quantity: 1, subtotal: 500)
    order5_item1 = OrdersItem.create(item_id: 9, order_id: 5, quantity: 1, subtotal: 1200)

    order6 = Order.create(user_id: 7, status: "paid", total: 600)
    order6_item17 = OrdersItem.create(item_id: 17, order_id: 6, quantity: 2, subtotal: 600)

    order7 = Order.create(user_id: 8, status: "cancelled", total: 700)
    order7_item18 = OrdersItem.create(item_id: 18, order_id: 7, quantity: 1, subtotal: 300)
    order7_item19 = OrdersItem.create(item_id: 19, order_id: 7, quantity: 1, subtotal: 400)

    order8 = Order.create(user_id: 9, status: "cancelled", total: 1000)
    order8_item20 = OrdersItem.create(item_id: 20, order_id: 8, quantity: 2, subtotal: 1000)

    order9 = Order.create(user_id: 1, status: "completed", total: 2000)
    order9_item1 = OrdersItem.create(item_id: 1, order_id: 9, quantity: 2, subtotal: 2000)

    order10 = Order.create(user_id: 2, status: "completed", total: 1100)
    order10_item7 = OrdersItem.create(item_id: 7, order_id: 10, quantity: 2, subtotal: 1100)
  end


  def build_items
    item1 = Item.create(title: "Canteen", description: "It holds the water for you", price: 1000, image: open("app/assets/images/canteen.jpg"), supplier_id: 1)
    item2 = Item.create(title: "Water", description: "Just water to drink", price: 850, image: open("app/assets/images/water.jpg"), supplier_id: 1)
    item3 = Item.create(title: "Water Purifier", description: "Purfiy your water", price: 8000, image:open("app/assets/images/water_purifier.jpg"), supplier_id: 2)
    item4 = Item.create(title: "Water Tablets", description: "Great way to purify small amounts of water", price: 689, image: open("app/assets/images/water_tablets.jpg"), supplier_id: 2)
    item5 = Item.create(title: "Water-Beans", description: "Just imagine this was a can of water", price: 899, image: open("app/assets/images/beans.jpg"), supplier_id: 3)
    item6 = Item.create(title: "Beans", description: "Yummy Beans", price: 500, image: open("app/assets/images/beans.jpg"), supplier_id: 3)
    item7 = Item.create(title: "Baby Formula", description: "Food for babies", price: 550, image: open("app/assets/images/formula.jpg"), supplier_id: 4)
    item8 = Item.create(title: "Soup", description: "Canned Soup", price: 750, image: open("app/assets/images/soup.jpg"), supplier_id: 4)
    item9 = Item.create(title: "Tuna", description: "Chicken of the sea", price: 1200, image: open("app/assets/images/tuna.jpg"), supplier_id: 5)
    item10 = Item.create(title: "More beans", description: "So many beans!!!", price: 650, image: open("app/assets/images/beans.jpg"), supplier_id: 5)
  end

  def build_items_category
    test1 = ItemsCategory.create(item_id: 1, category_id: 3)
    test2 = ItemsCategory.create(item_id: 2, category_id: 2)
    test3 = ItemsCategory.create(item_id: 3, category_id: 3)
    test4 = ItemsCategory.create(item_id: 4, category_id: 3)
    test5 = ItemsCategory.create(item_id: 5, category_id: 2)
    test6 = ItemsCategory.create(item_id: 6, category_id: 4)
    test7 = ItemsCategory.create(item_id: 7, category_id: 5)
    test8 = ItemsCategory.create(item_id: 8, category_id: 1)
    test9 = ItemsCategory.create(item_id: 9, category_id: 5)
    test10 = ItemsCategory.create(item_id: 10, category_id: 1)
  end

  def build_category
    category1 = Category.create(name: "Water", description: "Water Options")
    category2 = Category.create(name: "Power", description: "Power Supplies")
    category3 = Category.create(name: "Clothes", description: "Clothing")
    category4 = Category.create(name: "Food", description: "Food options")
    category5 = Category.create(name: "Communications", description: "Communicate clearly")
  end


  def build_users
    user1 = User.create(fullname: "Johnny Bravo", email: "hooaa@gmail.com", display_name: "jbravo", password: "password", role: 0)
    user2 = User.create(fullname: "Rachel Warbelow", email: "demo+rachel@jumpstartlab.com", password: "password", role: 0)
    user3 = User.create(fullname: "Jeff Casmir", email: "demo+jeff@jumpstartlab.com", display_name: "j3", password: "password", role: 0)
    user4 = User.create(fullname: "Jeorge Tellez", email: "demo+jorge@jumpstartlab.com", display_name: "novohispano", password: "password", role: 0)
    user5 = User.create(fullname: "Josh Cheek", email: "demo+josh@jumpstartlab.com", display_name: "josh", password: "password", role: 2, image: "cheeky.jpg")
    user6 = User.create(fullname: "Steve Kinney", email: "demo+steve@jumpstartlab.com", display_name: "steveo", password: "password", role: 0)
    user7 = User.create(fullname: "Horace Williams", email: "demo+horace@jumpstartlab.com", display_name: "horace", password: "password", role: 0)
    user8 = User.create(fullname: "Raissa Shafer", email: "demo+raissa@jumpstartlab.com", password: "password", role: 0)
    user9 = User.create(fullname: "Josh Mejia", email: "demo+jmeija@jumpstartlab.com", display_name: "meija", password: "password", role: 0)
    user10 = User.create(fullname: "Joe Blow", email: "joe@gmail.com", display_name: "joe", password: "joe", role: 1, image: "joe_blow.jpg")
  end

	def	build_supplier_admin
		SupplierAdmin.create(user_id: 10, supplier_id: 1)
	end

	def build_supplier
		Supplier.create(name: "Joe's big warehouse", slug: "joe-s-big-warehouse", description: "the best", retired: false, address: "1510 blake St. , CO" )
		Supplier.create(name: "Get Relief Now", slug: "get-relief-now", description: "one stop shop for emergency supplies", retired: false, address: "2020 blake St. , ME " )
		Supplier.create(name: "Big Supplies", slug: "big-supplies", description: "oversized supplies", retired: false, address: "2000 lake St. , IL " )
		Supplier.create(name: "To the Rescue", slug: "to-the-rescue", description: "Supplies for those in need.", retired: false, address: "20 bake St. , CA " )
		Supplier.create(name: "Band-Aid", slug: "band-aid", description: "temporary solutions for big problems", retired: false, address: "2 baker St. , NY " )
	end
end
Seed.new
