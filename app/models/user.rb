class User < ActiveRecord::Base
  has_secure_password
  validates :fullname, :role, presence: true 
	validates :password, presence: true, on: :create
  validates :email, presence: true, uniqueness: true, on: :create
  validates :display_name, length: { in: 2..32 }, allow_nil: true, on: :create
  has_many :orders, through: :addresses
  has_one :supplier_admin


  enum role: %w(default supplier admin)

  def supplier_slug(id)
    find_supplier_admin(id).supplier.slug
  end

  def has_company?(id)
    !find_supplier_admin(id).nil?
  end

  def find_supplier_admin(id)
    SupplierAdmin.find_by(user_id: id)
  end
end
