class User < ActiveRecord::Base
  has_secure_password
  validates :fullname, :password, :role, presence: true
  validates :email, presence: true, uniqueness: true
  validates :display_name, length: { in: 2..32 }, allow_nil: true
  has_many :orders
  has_one :supplier_admin


  enum role: %w(default supplier_admin super_admin)

  def admin?
    role == "super_admin"
  end

  def supplier?
    role == "supplier_admin"
  end

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
