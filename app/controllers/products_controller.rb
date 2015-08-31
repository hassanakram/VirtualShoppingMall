class ProductsController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :new, :create, :update]
  before_filter :set_product, only: [:show, :edit, :update, :destroy]
  before_filter :validate_user, only: [:edit, :update, :destroy]

  respond_to :html

  def index
    if params[:search_query].present?
      @products = Product.ordered.search(params[:search_query], page: params[:page], per_page: Product::PER_PAGE_SIZE)
    else
      @products = Product.ordered.page(params[:page])
    end
    respond_with(@products)
  end

  def show
    @reviews = @product.reviews.ordered.page(params[:page])
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
    respond_to do |format|
      format.html { @product.save ? (redirect_to @product, notice: "Product created successfully.") : (redirect_to new_product_path, alert: "Error creating product.") }
    end
  end

  def update
    @product.update_attributes(params[:product])
    respond_to do |format|
      format.html { @product.save ? (redirect_to @product, notice: "Product saved successfully.") : (redirect_to edit_product_path(@product), alert: "Error saving product.") }
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html {redirect_to current_user, notice: "Product deleted successfully."}
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def validate_user
      return(redirect_to root_path, alert: "Unauthorized Access") unless current_user.is_owner?(@product.user_id)
    end
end
