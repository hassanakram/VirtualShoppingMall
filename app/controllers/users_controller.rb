class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:dashboard]

  def show
    @user = User.find(params[:id])
    @products = @user.products.includes(:images).ordered.page(params[:page])
  end

  def dashboard
    @products = current_user.products.includes(:images).ordered.page(params[:product_page])
    @reviews = current_user.reviews.page(params[:review_page])
  end
end
