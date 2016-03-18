class SessionsController < ApplicationController
  
  def new
    render :layout => false 
  end

  def create
  	if @user = User.find_by(email: params[:email]) and @user.authenticate(params[:password])
  		session[:user_id] = @user.id #sets session
      current_user = @user[params]
  		redirect_to root_path, flash: {success: "Logged in"}
  	else
  		flash.now[:error] = "Invalid login credentials"
  		render 'new'
  	end
  end


  def destroy
  	session[:user_id] = nil
  	redirect_to root_path
  end

  	private
		def user_params
			params.require(:user).permit(:username, :email, :password, :password_confirmation)
		end

end
