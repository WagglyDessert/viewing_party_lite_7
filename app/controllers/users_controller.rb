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
    if new_user.save
      session[:user_id] = new_user.id
      flash[:success] = "Welcome, #{new_user.username}!"
      redirect_to "/users/#{new_user.id}"
    else
      flash[:notice] = "#{new_user.errors.full_messages.join(', ')}"
      redirect_to "/register"
    end
  end

  def login_form
  end

  def login
    user = User.find_by(username: params[:username])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.username}!"
      redirect_to "/"
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "You have been logged out successfully."
    redirect_to "/"
  end

  private
  def users_params
    params.require(:user).permit(:email, :name, :username, :password, :password_confirmation)
  end

end
