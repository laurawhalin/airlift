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

  def items
    data.keys.map do |item_id|
      [Item.find(item_id), data[item_id]]
    end

  end
end
