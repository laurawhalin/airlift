def item_attributes(overrides={})
	{
	 title: "Water Purifier",
	 description: "Water purification system with pump and cartridge.",
	 price: 500,
	 retired: false,
	 quantity: 50,
	 supplier_id: 1
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
		 email: "joe@gmial.com",
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
   total: 5000,
  }.merge(overrides)
end

