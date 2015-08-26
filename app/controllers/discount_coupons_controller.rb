class DiscountCouponsController < ApplicationController

  def valid_token
    @valid_token = DiscountCoupon.get_valid_token(params[:discount_coupons][:coupon_number])

    respond_to do |format|
      format.js {}
    end
  end

end
