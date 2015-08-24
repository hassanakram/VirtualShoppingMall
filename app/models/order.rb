class Order < ActiveRecord::Base
  attr_accessible :address

  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items
  belongs_to :discount_coupen

end
