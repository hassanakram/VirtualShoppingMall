class Order < ActiveRecord::Base
  attr_accessible :address

  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items
  belongs_to :discount_coupen

  ORDER_COOKIES = [:cart_items, :discount_price, :total_items, :total_price, :coupen, :discount_percentage]

  def update_order(order_params)
    self.order_items = products.collect do |product|
      product.order_items.create
    end
    self.discount_coupon_id = order_params[:token].id if order_params[:token]
    self.amount = order_params[:amount]
    self.order_status = "purchased"
    OrderMailer.order_confirmation(order_params[:current_user]).deliver
    Order.destroy_cookies(order_params[:cookies])
    self.save
  end

  def self.destroy_cookies(cookies)
    ORDER_COOKIES.each do |cookie|
      cookies.delete cookie
    end
  end

end
