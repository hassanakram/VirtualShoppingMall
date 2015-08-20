class UsersController < ApplicationController
  def show
    @user = User.includes(products: [:reviews, :images]).includes(reviews: [:product]).find(params[:id])
    @products = @user.products.ordered.page(params[:product_page])
    @reviews = @user.reviews.ordered.page(params[:review_page])
  end
end
