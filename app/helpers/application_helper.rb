module ApplicationHelper
  def authorised_owner(user_id)
    user_signed_in? && current_user.id == user_id
  end

  def render_title(title)
    title.blank? ? title.titleize : ""
  end
end
