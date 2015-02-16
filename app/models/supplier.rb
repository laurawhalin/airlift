class Supplier < ActiveRecord::Base
	has_many :items
  has_many :supplier_admins
  has_many :users, through: :supplier_admins
end
