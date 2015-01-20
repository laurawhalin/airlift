class Item < ActiveRecord::Base
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :image, presence: true
  has_many :items_categories
  has_many :categories, through: :items_categories
  has_many :order_items
  has_many :orders, through: :order_items
end
