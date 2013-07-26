class AdminController < ApplicationController
  def index
    authorize! :admin, :index if respond_to?(:authorize!)
  end
end