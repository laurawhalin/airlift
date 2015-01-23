class Cart
  attr_reader :data

  def initialize(input_data)
    @data = input_data || Hash.new
  end

  def add_item(item)
    data[item.id.to_s] ||= 0
    data[item.id.to_s] += 1
  end

  def count_of(item)
    data[item.id.to_s]
  end

  def count_total
    data.values.sum
  end

  def line_items
    data.keys.map do |item_id|
      item = Item.find(item_id)
      quantity = data[item_id]
      subtotal = (item.price * quantity) / 100
      [item, quantity, subtotal]
    end
  end
end
