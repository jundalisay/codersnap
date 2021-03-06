class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login

  def current_user
    User.where(id: session[:user_id]).first
  end
  
private

  # def current_user
  #   # return @current_user if @current_user
  #   # if session[:user_id]
  #   @current_user ||= User.find_by_id session{:user_id} #caches the current_user
  # end



  helper_method :current_user #gives the method to the view

  def require_login
    unless !current_user.nil?
      respond_to do |format|
        format.html do
          flash[:error] = "You must be logged in to access this content."
          redirect_to login_path
        end
        format.js do
          render 'sessions/fail'
        end
      end
    end
  end

  def search_params
    params.require(:search_form).permit(:search_for)
  end

end