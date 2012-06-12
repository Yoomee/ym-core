class SuperController < ApplicationController
  before_filter :reject_non_yoomee_staff
  def index
  end
  
  def morph
    user = User.find(params[:user_id])
    sign_in(user)
    redirect_to user
  end
  
  private
  def reject_non_yoomee_staff
    redirect_to root_path unless current_user && current_user.yoomee_staff?
  end
end