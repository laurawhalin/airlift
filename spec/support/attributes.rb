def item_attributes(overrides={})
	{
	 title: "water purifier",
	 description: "good",
	 price: 500,
	 retired: false,
	 quantity: 50,
   supplier_id: 1
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

def supplier_attributes(overrides={})
	{
	 name: "Fireproof",
	 address: "1234 Blake st.",
	 slug: "fireproof",
	 description: "Fire disaster products",
	 retired: false
	}.merge(overrides)
end
