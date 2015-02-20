class Item < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :supplier_id, presence: true
  validates :price, presence: true, numericality: { :greater_than_or_equal_to => 0 }
	validates :supplier_id, presence: true
  has_attached_file :image, styles: { medium: "300x300>",
                                        thumb: "100x100>" },
                                        default_url: "beans.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  has_many :items_categories
  has_many :categories, through: :items_categories
  has_many :orders_items
  has_many :orders, through: :orders_items
	belongs_to :supplier

  def self.search(search)
    if search
      query = "%#{search.downcase}%"
      self.all.where("lower(title) LIKE ? OR lower(description) LIKE ?", query, query)
    else
      self.all
    end
  end

  def item_supplier
    supplier_id = self.supplier_id
    Supplier.find(supplier_id).slug
  end

  def item_categories
    items_categories = self.items_categories.all
    category_ids = items_categories.map { |ic| ic.category_id }
    category_ids.map { |category_id| Category.find(category_id) }
  end
end
