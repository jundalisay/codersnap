class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  layout nil

  def new
    # redirect_to root_path if signed_in?
    render :layout => false 
  end

  def create

  	if @user = User.find_by(email: params[:email]) and @user.authenticate(params[:password])
  		session[:user_id] = @user.id #sets session
      current_user = @user[params]
  		redirect_to root_path, flash: {success: "Logged in"}
  	else
  		flash.now[:error] = "Invalid login credentials"
  		render 'new', :layout => false
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to root_path
  end

######################
  private
		def user_params
			params.require(:user).permit(:username, :email, :password, :avatar) #, :password_confirmation
		end

    def sign_in(user)
    self.current_user = user
  end

  def sign_out
    self.current_user = nil
  end

  def signed_in?
    !current_user.nil?
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def current_user=(user)
    @current_user = user
  end

  # def current_user
  #   @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  # end

  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

  def valid_users?(*users)
    current_user.admin || users.any? { |user| current_user? user }
  end

  def validate_users(*users)
    unless valid_users?(*users)
      flash[:error] = "Unauthorized to access that content."
      redirect_to root_path
    end
  end

end
