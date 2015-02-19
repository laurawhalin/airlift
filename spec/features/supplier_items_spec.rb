feature "supplier visits the site" do
  before(:each) do
    @user = User.create(user_attributes({role: 1}))
    @supplier = Supplier.create(supplier_attributes)
    @item = @supplier.items.create(item_attributes)
    @supplier_admin = SupplierAdmin.create( user_id: @user.id, supplier_id: @supplier.id)
  end
	
	scenario "Supplier can create a new item" do
		visit supplier_items_path(@suplier.slug)
		click_link_or_button "Create New Item"
		
	end
end
