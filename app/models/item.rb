class Item < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  has_many :items_categories
  has_many :categories, through: :items_categories
  has_many :orders_items
  has_many :orders, through: :orders_items

  def retired?
    
  end
end
