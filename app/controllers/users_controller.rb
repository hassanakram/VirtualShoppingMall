class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @products = @user.products.ordered.page(params[:page])
  end

end
