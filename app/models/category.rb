class Category < ActiveRecord::Base
  validates :name, :description, presence: true
  validates :name, uniqueness: true
  has_many :item_categories
  has_many :items, through: :item_categories
end
