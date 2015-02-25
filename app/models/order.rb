class Order < ActiveRecord::Base
  validates :status, presence: true
  validates :total, presence: true
  has_many :orders_items
  has_many :items, through: :orders_items
  has_many :addresses

  def self.status_counts(status_type)
    group(:status).having(status: status_type).count
  end

  def self.id_for(slug)
    Supplier.find_by(slug: slug).id
  end

  def change_status(commit)
    if commit == "Cancel Order"
      update(status: "cancelled")
    else commit == "Mark as Shipped"
      update(status: "completed")
    end
  end

  def self.get_supplier_orders_by_status(params)
    supplier_orders = self.get_supplier_orders(params)
    supplier_orders.flatten.group_by { |order| order.status }
  end

  def self.get_supplier_orders(params)
    items = Item.where(supplier_id: self.id_for(params[:slug]))
    items.map do |item|
      Order.joins(:orders_items).where(orders_items: { item_id: item.id })
    end.flatten.uniq
  end

  def self.get_order_and_items(id)
    self.includes(:orders_items).find(id)
  end

  def get_user(order)
    User.find(order.addresses.where(address_type: "billing").first.user_id)
  end
end
