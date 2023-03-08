class OrderShipping
  include ActiveModel::Model
  attr_accessor :post_code, :region_id, :city, :block, :building, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :block
    validates :phone_number, format: {with: /\A0\d{9,10}\z/, message: "is invalid."}
    validates :user_id
    validates :item_id
  end
  validates :region_id, numericality: { other_than: 1 , message: "can't be blank" } 

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Shipping.create(post_code: post_code, region_id: region_id, city: city, block: block, building: building, phone_number: phone_number, order_id: order.id)
  end
end