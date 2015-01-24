module Admin
  class AdminController < ApplicationController
  before_action :verify_admin
    private
    def verify_admin
      redirect_to root_url unless current_user && current_user.role == "admin"
    end
  end
end
