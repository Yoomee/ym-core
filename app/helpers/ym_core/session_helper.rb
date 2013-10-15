module YmCore::SessionHelper

  def current_user?
    if defined? current_user
      current_user.present?
    else
      false
    end
  end

end