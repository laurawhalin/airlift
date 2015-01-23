class Order < ActiveRecord::Base
  validates :user_id, presence: true
  validates :status, presence: true
  validates :total, presence: true
  has_many :orders_items
  has_many :items, through: :orders_items
  belongs_to :user

  # scope :completed -> { where(status: "completed") }
  # scope :expensive -> { where("price > ?", 100) }
  #
  # def self.completed
  #   where(status: "completed")
  # end
end
