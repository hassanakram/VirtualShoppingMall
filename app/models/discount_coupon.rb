class DiscountCoupon < ActiveRecord::Base

  attr_accessible :active, :coupen_number, :discount_percentage

  validates :coupen_number, presence: true
  validates :discount_percentage, presence: true, inclusion: { in: 1..99, message: "Percentage should be between 1 to 99" }

  has_many :orders

  scope :by_coupon_number, ->(coupon_number) { where(coupen_number: coupon_number) }

  def self.get_valid_token( coupon_number )
    discount = DiscountCoupon.by_coupon_number(coupon_number).first
    return discount if discount.present? && discount.active
  end

end
