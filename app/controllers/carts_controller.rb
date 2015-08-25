class CartsController < ApplicationController

  def show
    @products = cookies["cart_items"].present? ? Product.find(cookies["cart_items"].split(',')) : nil
  end

end
