class Order < ActiveRecord::Base
  validates :users_id, presence: true
  validates :status, presence: true
  validates :total, presence: true
  has_many :orders_items
  has_many :items, through: :orders_items
  belongs_to :user
end
