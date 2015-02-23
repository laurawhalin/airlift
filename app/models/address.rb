class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  validates :line_one,
            :city,
            :state,
            :postal_code,
            :country,
            :address_type,
            :user_id,
            :order_id,
            presence: true
end
