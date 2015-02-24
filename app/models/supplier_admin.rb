class SupplierAdmin < ActiveRecord::Base
  validates :user_id, :supplier_id, presence: true
  has_one :user
  belongs_to :supplier

end
