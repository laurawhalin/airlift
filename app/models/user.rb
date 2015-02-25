class User < ActiveRecord::Base
  has_secure_password
  validates :fullname, :password, :role, presence: true
  validates :email, presence: true, uniqueness: true
  validates :display_name, length: { in: 2..32 }, allow_nil: true
  has_one :supplier_admin
  has_many :addresses
  has_many :orders, through: :addresses


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

  def get_shipping_address(user)
    user.addresses.find_by(address_type: "shipping")
  end
end
