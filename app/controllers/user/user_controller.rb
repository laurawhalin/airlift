module User
  class UserController < ApplicationController
    before_action :verify_user
    # should we move current_user here???
    private
    def verify_user
      redirect_to root_url unless current_user && current_user.role #???
    end
  end
end
