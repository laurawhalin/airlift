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

  def delete_item(item_id)
    data.delete(item_id.to_s)
    data
  end

  def total
    unless self.data.empty?
      data.keys.map do |item_id|
        item = Item.find(item_id)
        item.price * quantity = data[item_id]
      end.reduce(:+) / 100
    end
  end
  # def edit_quantity
  #   byebug
  #   quantity = line_items[0][1]
  #   #set edit_quantity to equal = dropdown number
  # end
end
