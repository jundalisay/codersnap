class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :show, :index, :destroy]

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_users?, only: [:edit, :update, :destroy]

	def index
		@users = User.all
	end

	def new
		@user = User.new
		render :layout => false 
	end	

	def create
		@user = User.create user_params
		
		# if @user.persisted?
		if @user.save
			session[:user_id] = @user.id
			flash[:success] = 'Registered!'
			redirect_to root_path
		else
			render 'new'
			flash.now[:error] = "Invalid info!"
		end
	end

	def show
		@user = User.find(params[:id])
	end

	private
		def user_params
			params.require(:user).permit(:username, :email, :password, :password_confirmation, :avatar)
		end

end