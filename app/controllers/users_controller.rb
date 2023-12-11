class UsersController < ApplicationController

  def show
    @user = User.find(params[:user_id])
  end
  
  def new
    @user = User.new
  end

  def create
    new_user = User.create(users_params)
		flash[:success] = "Welcome, #{new_user.username}!"
    # user = users_params
    # user[:username] = user[:username].downcase
    # new_user = User.create(user)
    # flash[:notice] = "Welcome, #{new_user.username}!"
    redirect_to "/users/#{new_user.id}"
    # else
    #   flash[:notice] = "This email or username is already registered"
    #   redirect_to "/register"
    # end
  end

  private
  def users_params
    params.require(:user).permit(:email, :name, :username, :password, :password_confirmation)
  end

end
