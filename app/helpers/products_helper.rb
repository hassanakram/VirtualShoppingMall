module ProductsHelper

  def authorised_user(user)
    user_signed_in? && current_user.id == user.id
  end

end
