class Item < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :supplier_id, presence: true
  validates :price, presence: true, numericality: { :greater_than_or_equal_to => 0 }
	validates :supplier_id, presence: true
  validates :location, presence: true
  has_attached_file :image, styles: { medium: "300x300>",
                                      thumb: "100x100>" },
                                      default_url: "items/beans_:style.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  has_many :item_categories
  has_many :categories, through: :item_categories
  has_many :orders_items
  has_many :orders, through: :orders_items
	belongs_to :supplier

  def self.search(search)
    if search
      query = "%#{search.downcase}%"
      where("lower(title) LIKE ? OR lower(description) LIKE ?", query, query)
    else
      all
    end
  end

  def item_supplier
    supplier_id = self.supplier_id
    Supplier.find(supplier_id).slug
  end

  def add_categories_to_item(categories)
    categories.each do |cat_name|
      self.categories << Category.find_by(name: cat_name)
    end
  end

  def item_available
    if self.available
      "Currently Available"
    else
      "Not Currently Available"
    end
  end

  def item_shippable
    if self.shippable
      "Shipping Available"
    else
      "Pick Up Only"
    end
  end

  def format_price
    self.price.to_f / 100.00
  end

  def item_retired
    if self.retired
      "Retired"
    else
      "Active"
    end
  end

end
