module ApplicationHelper

  def administrator?(event)
    event.administrator == current_user
  end

  def participant?(event)
    event.users.include?(current_user)
  end
end
