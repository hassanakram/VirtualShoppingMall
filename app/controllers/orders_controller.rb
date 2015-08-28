class OrdersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_cart

  def new
    @user_token = generate_client_token
  end

  def create
    @result = Braintree::Transaction.sale(
              amount: session['total_amount'],
              payment_method_nonce: params[:payment_method_nonce])

    if @result.success?
      order = current_user.orders.create
      order_params = { products: @products, amount: session['total_amount'], token: @token, cookies: cookies, current_user: current_user }
      order.update_order(order_params)
      redirect_to root_url, notice: "Congraulations! Your transaction has been successfully!"
    else
      flash[:alert] = "Something went wrong while processing your transaction. Please try again!"
      @user_token = generate_client_token
      render :new
    end
  end

  private
    def generate_client_token
      Braintree::ClientToken.generate
    end

    def check_cart
      if cookies["cart_items"].present?
        @products = Product.find(cookies["cart_items"].split(','))
        @token = DiscountCoupon.get_valid_token(cookies['coupen'])
        total_price = @products.sum(&:price)
        discount_percentage = @token ? (@token.discount_percentage/100.to_f) : 0
        @total_amount = session['total_amount'] = total_price - total_price * discount_percentage
      else
        redirect_to products_path, notice: "Empty Cart. Please add some products to cart before checkout"
      end
    end

end
