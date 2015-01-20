class User < ActiveRecord::Base
  validates :fullname, :password, :role, presence: true
  validates :email, presence: true, uniqueness: true
  validates :display_name, length: { in: 2..32 }, allow_nil: true
end
