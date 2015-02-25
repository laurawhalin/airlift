module SupplierUsersHelper
	def invalid_user_count?
		!User.valid_supplier_count?
	end
end
