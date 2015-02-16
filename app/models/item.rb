class Item < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { :greater_than_or_equal_to => 0 }
  has_attached_file :image, styles: { medium: "300x300>",
                                        thumb: "100x100>" },
                                        default_url: "batteries.jpg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  has_many :items_categories
  has_many :categories, through: :items_categories
  has_many :orders_items
  has_many :orders, through: :orders_items
	belongs_to :supplier

  def self.search(search)
    if search
      # find(:all, :conditions => ['title LIKE ? || description LIKE ?', "%#{search}%", "%#{search}%"])
      where("title LIKE ? OR description LIKE ?", "%#{search}%", "%#{search}%") #:conditions => ['title LIKE ?', "%#{search}%"]
    else
      self.all
    end
  end
end
