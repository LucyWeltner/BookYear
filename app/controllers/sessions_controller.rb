require 'pry'
class SessionsController < ApplicationController
	def new
		if is_logged_in?
			flash[:alert] = "You cannot log in - you are already logged in!"
			redirect_to profile_path
		else 
			render 'new'
		end
	end
	def create
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			flash[:success] = "Welcome to BookYear, #{user.username}"
			redirect_to profile_path
		else 
			@errors = ["Your username or password is incorrect. Please try again."]
		end
	end
	def destroy
		session.delete(:user_id)
		redirect_to root_path
	end
end