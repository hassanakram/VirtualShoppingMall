class CartsController < ApplicationController

  def show
    @products = cookies["cart_items"].present? ? Product.find(cookies["cart_items"].split(',')) : []
    @token = DiscountCoupon.get_valid_token(cookies['coupen'])
    total_price = @products.sum(&:price)
    cookies['total_items'] = @products.count
    cookies['total_price'] = total_price
    cookies['discount_price'] = cookies['coupen'] ? (total_price - (total_price * cookies['discount_percentage'].to_f)) : total_price
  end

end
