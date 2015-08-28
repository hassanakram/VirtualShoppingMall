class DiscountCouponsController < ApplicationController

  def valid_token
    @valid_token = DiscountCoupon.get_valid_token(params[:discount_coupons][:coupon_number])

    if @valid_token
      cookies['coupen'] = @valid_token.coupen_number
      cookies['discount_percentage'] = (@valid_token.discount_percentage.to_f / 100.to_f)
    end
    respond_to do |format|
      format.js {}
    end
  end

end
