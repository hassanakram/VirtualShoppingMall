class DiscountCoupon < ActiveRecord::Base
  attr_accessible :valid, :coupen_number, :discount_percentage

  has_many :orders

end
