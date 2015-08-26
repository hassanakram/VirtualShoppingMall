class DiscountCoupon < ActiveRecord::Base

  has_many :orders

  scope :by_coupon_number, ->(coupon_number) { where(coupen_number: coupon_number) }

  def self.get_valid_token( coupon_number )
    discount = DiscountCoupon.by_coupon_number(coupon_number).first
    return discount if discount.present? && discount.active
  end

end
