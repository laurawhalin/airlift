class AddColumnsToItems < ActiveRecord::Migration
  def change
    add_column :items, :available, :boolean, default: true
    add_column :items, :unit_size, :integer, default: 100
    add_column :items, :location, :string
    add_column :items, :shippable, :boolean, default: true
    add_column :items, :unit_weight, :integer, default: 100
  end
end
