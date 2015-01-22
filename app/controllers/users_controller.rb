class UsersController < ApplicationController
  before_filter :authorize, only: [:show]

  # def index
  #   @users = User.all
  # end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      auto_login(@user)
      flash[:success] = "You have successfully registered."
      redirect_to root_url
    else
      flash[:errors] = "Unsuccessful login."
      render :new
    end
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
