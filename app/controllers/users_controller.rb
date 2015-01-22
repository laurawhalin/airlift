class UsersController < ApplicationController
  before_filter :authorize, only: [:show]

  # def index
  #   @users = User.all
  # end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    flash[:success] = "You have successfully registered."
    redirect_to "/"
    #make sure user is logged in when created
    #flash success message when user is created
    #else render new possible error flash message

  end

  def show
    @user = User.find(params[:id])
    # authorize! :read, @user
  end
  
  private

  def user_params
    params.require(:user).permit(:full_name,
                                 :email,
                                 :password,
                                 :display_name)
  end
end
