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

  def change_status(order, commit)
    if commit == "Cancel Order"
      @order = order.update(status: "cancelled")
    elsif commit == "Mark as Shipped"
      @order = order.update(status: "completed")
    else
      @order
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

  def self.get_order(params)
    # items = Item.where(supplier_id: self.id_for(params[:slug]))
    # require 'pry' ; binding.pry
    # @order = Order.joins(:orders_items).where(orders_items: { order_id: params[:id] } )
    require 'pry' ; binding.pry
    supplier_orders = self.get_supplier_orders(params)
    supplier_orders.find(params[:id])

    # return the order from params[:id]
    # only search from the orders relevant to this user
  end

  def self.get_items(params)
    items = Item.where(supplier_id: self.id_for(params[:slug]))

  end

  def self.get_user(order)
    User.find(order.addresses.where(address_type: "billing").first.user_id)
  end

  def self.get_shipping_address(user)
    user.addresses.where(address_type: "shipping").first
  end
end
