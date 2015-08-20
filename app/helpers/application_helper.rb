module ApplicationHelper
  def authorised_owner(user_id)
    current_user.id == user_id
  end
end
