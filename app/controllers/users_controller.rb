class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_users?, only: [:edit, :update, :destroy]

	def index
		# @users = User.all
		# User.all :conditions => (current_user ? ["id != ?", current_user.id] : [])
		@users = User.where("id != ?", current_user.id)
	end

	def new
		# sign_out unless current_user
		@user = User.new
		render :layout => false 
	end	

	def create
		@user = User.create user_params
		# @user = User.new(user_params)

		if @user.persisted?

		# if @user.save
			# UserMailer.user_confirmation_email(@user).deliver
			session[:user_id] = @user.id
			flash[:success] = 'Registered!'
			redirect_to login_path
		else
			flash.now[:error] = "#{@user.errors.full_messages.to_sentence}"
			render 'new'
		end
	end


	def show
		@user = User.find(params[:id])
	end

	private
		def user_params
			params.require(:user).permit(:recipient_id, :username, :email, :password, :password_confirmation, :avatar) #, :password_confirmation, :new_password, :new_password_confirmation, :password_confirmation
		end

def hash_new_password
    unhashed_password = new_password || password
     unless unhashed_password.blank?
       self.hashed_password = BCrypt::Password.create(unhashed_password)
     end
  end
end