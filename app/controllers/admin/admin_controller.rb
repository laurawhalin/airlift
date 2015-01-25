module Admin
  class AdminController < ApplicationController
  before_action :verify_admin
  def show

  end
    private
    def verify_admin
      redirect_to root_url unless current_user && current_user.role == "admin"
    end
  end
end
