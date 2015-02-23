def item_attributes(overrides={})
	{
	 title: "Water Purifier",
	 description: "Water purification system with pump and cartridge.",
	 price: 500,
	 retired: false,
	 quantity: 0,
	 supplier_id: 1,
	 available: true,
	 unit_size: 100,
	 location: "Denver, CO, USA",
	 shippable: true,
	 unit_weight: 100
	}.merge(overrides)
end

def category_attributes(overrides={})
	{
		name: "Water",
		description: "Drinkable goods."
	}.merge(overrides)
end

def user_attributes(overrides={})
	{
	   fullname: "Joe Guy",
		 email: "joe@gmial.com",
		 role: 0,
		 password: "foobar1234",
		 password_confirmation: "foobar1234",
		 display_name: "foo"
	}.merge(overrides)
end

def admin_user_attributes(overrides={})
	{
	   fullname: "Joe Admin",
		 email: "joe_admin@gmial.com",
		 role: 1,
		 password: "foobar1234",
		 password_confirmation: "foobar1234",
		 display_name: "foo"
	}.merge(overrides)
end

def supplier_attributes(overrides={})
	{
	 name: "Fireproof",
	 address: "1234 Blake st.",
	 slug: "fireproof",
	 description: "Fire disaster products",
	 retired: false
	}.merge(overrides)
end

def supplier_admin_attributes(overrides={})
	{
		user_id: 1,
		supplier_id: 1
	}.merge(overrides)
end

def order_attributes(overrides={})
  {
   status: "ordered",
   total: 5000
  }.merge(overrides)
end

def shipping_address_attributes(overrides={})
	{
		line_one: "Relief Supplier Acme",
		line_two: "1410 Forever St",
		city: "Denver",
		state: "CO",
		postal_code: "80202",
		country: "United States",
		address_type: "shipping"
	}
end

def billing_address_attributes(overrides={})
	{
		line_one: "Relief Supplier Acme",
		line_two: "1550 Blake St",
		city: "Denver",
		state: "CO",
		postal_code: "80222",
		country: "United States",
		address_type: "billing",
	}
end
