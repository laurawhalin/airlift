class Supplier < ActiveRecord::Base
	validates :name, presence: true
	validates :description, presence: true
	has_many :items
  has_many :supplier_admins
  has_many :users, through: :supplier_admins

	before_update :update_slug

	def update_slug
		self.slug = name.parameterize
	end

	def find_user_admins
		supplier_admins.map { |supplier_admin| User.find_by(id: supplier_admin.user_id) }
	end

	def valid_supplier_admins?
		supplier_admins.count > 1 
	end
end
