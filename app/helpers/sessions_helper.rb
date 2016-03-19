require 'bcrypt'

module SessionsHelper

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

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end

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
