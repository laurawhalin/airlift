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
end
