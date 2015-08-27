class ReviewsController < ApplicationController
  before_filter :authenticate_user!, only: [:edit, :new, :create, :update]
  before_filter :set_review, only: [:show, :edit, :update, :destroy]
  before_filter :set_product
  before_filter :authorise_edit, only: [:edit, :update]
  before_filter :authorise_create, only: [:new, :create]
  before_filter :authorise_delete, only: [:destroy]

  respond_to :html

  def index
    @reviews = Review.all
    respond_with(@reviews)
  end

  def show
    respond_with(@review)
  end

  def new
    @review = Review.new
    respond_with(@review)
  end

  def edit
  end

  def create
    @review = @product.reviews.new(params[:review])
    @review.user = current_user
    @review.save

    respond_to do |format|
      format.js
    end
  end

  def update
    @review.update_attributes(params[:review])
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @review.destroy
    respond_to do |format|
      format.js
      format.html {redirect_to(dashboard_path, alert: "Review deleted successfully.")}
    end
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def set_product
      @product = Product.find(params[:product_id])
    end

    def authorise_edit
      return redirect_to(root_path, alert: "You can't review your product") unless current_user.is_owner?(@review.user_id)
    end

    def authorise_create
      return redirect_to(root_path, alert: "Unauthorized Access") if current_user.is_owner?(@product.user_id)
    end

    def authorise_delete
      return redirect_to(root_path, alert: "Unauthorized Access") unless current_user.is_owner?(@product.user_id) || current_user.is_owner?(@review.user_id)
    end
end
