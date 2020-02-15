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
		if auth
			user = User.find_or_create_by(uid: auth['uid'])
			user.username = auth['info']['name'] if !user.username
			user.email = auth['info']['email'] if !user.email
			user.password = SecureRandom.hex if !user.password_digest
			if user.save
				session[:user_id] = user.id
				redirect_to profile_path
			else
				flash[:alert] = "You already have an account, you cannot sign up through Facebook."
				redirect_to login_path
			end
		else 
			user = User.find_by(username: params[:username])
			if user && user.authenticate(params[:password])
				session[:user_id] = user.id
				flash[:success] = "Welcome to BookYear, #{user.username}"
				redirect_to profile_path
			else 
				flash[:alert] = "Your username or password is incorrect. Please try again."
				redirect_to login_path
			end
		end
	end
	def destroy
		session.delete(:user_id)
		redirect_to root_path
	end
	private
		def auth
			request.env["omniauth.auth"]
		end
end