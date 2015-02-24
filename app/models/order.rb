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
    Supplier.find_by(slug: slug)
  end

  def change_status(order, commit)
    if commit == "Cancel Order"
      @order = order.update(status: "cancelled")
    elsif commit == "Mark as Shipped"
      @order = order.update(status: "completed")
    else
      @order
    end
  end

  def self.get_supplier_orders(params)
    orders_items = self.id_for(params[:slug]).id
    supplier_orders = Order.joins(:orders_items).group(orders_items)
    @orders = supplier_orders.group_by { |order| order.status }
  end

  def self.get_order(current_user, order_id)
    Item.find_by(supplier_id: current_user.id).orders.find(order_id)
  end

  def self.get_user(order)
    User.find(order.addresses.where(address_type: "billing").first.user_id)
  end

  def self.get_shipping_address(user)
    user.addresses.where(address_type: "shipping").first
  end
end
