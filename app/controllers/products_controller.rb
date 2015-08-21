class ProductsController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :new, :create, :update]
  before_filter :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :validate_user, only: [:edit, :update, :destroy]

  respond_to :html

  def index
    @products = Product.ordered.page(params[:page])
    respond_with(@products)
  end

  def show
    @reviews = @product.reviews
    @review = @product.reviews.build
    respond_with(@product)
  end

  def new
    @product = Product.new
    respond_with(@product)
  end

  def edit
  end

  def create
    @product = Product.new(params[:product])
    @product.user_id = current_user.id
    @product.save
    respond_with(@product)
  end

  def update
    @product.update_attributes(params[:product])
    respond_with(@product)
  end

  def destroy
    @product.destroy
    respond_with(@product)
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def validate_user
      return(redirect_to root_path, alert: "Unauthorized Access") unless current_user.is_owner?(@product.user_id)
    end
end
