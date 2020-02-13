class UsersController < ApplicationController
	def new
		@user = User.new
	end 
	def create
		user = User.new(ok_params)
		if user.save
			flash[:success] = "You have successfully signed up, #{user.username}!"
			session[:user_id] = user.id
			redirect_to profile_path
		else
			@errors = user.errors.full_messages
			render 'new'
		end 
	end
	def show
		@user = find_object(params, "user")
	end

	def current
		@user = current_user
		render 'profile'
	end

	private
	def ok_params
		params.require(:user).permit(:username, :email, :password, :bio, :password_confirmation)
	end
end