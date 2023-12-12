class UsersController < ApplicationController

  def show
    @user = User.find(params[:user_id])
  end
  
  def new
    @user = User.new
  end

  def create
    user = users_params
    user[:username] = user[:username].downcase
    new_user = User.create(user)
		flash[:success] = "Welcome, #{new_user.username}!"
    redirect_to "/users/#{new_user.id}"
    # else
    #   flash[:notice] = "This email or username is already registered"
    #   redirect_to "/register"
    # end
  end

  def login_form
  end

  def login
    user = User.find_by(username: params[:username])
    flash[:success] = "Welcome, #{user.username}!"
    redirect_to "/"
  end

  private
  def users_params
    params.require(:user).permit(:email, :name, :username, :password, :password_confirmation)
  end

end
