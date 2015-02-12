class User < ActiveRecord::Base
  has_secure_password
  validates :fullname, :password, :role, presence: true
  validates :email, presence: true, uniqueness: true
  validates :display_name, length: { in: 2..32 }, allow_nil: true
  has_many :orders

  enum role: %w(default supplier_admin super_admin)

  def admin?
    role == "super_admin"
  end

  def supplier?
    role == "supplier_admin"
  end

  def supplier_slug(id)
    SupplierAdmin.find_by(user_id: id).supplier.slug
  end
end
