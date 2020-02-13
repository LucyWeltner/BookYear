class ApplicationController < ActionController::Base
	private
	def is_logged_in?
		!!session[:user_id]
	end

	def current_user
		User.find_by_id(session[:user_id])
	end
	
	def find_object(param_hash, class_name)
		Module.const_get(class_name.capitalize).find_by_id(param_hash[:id])
	end

	def make_errors(instance)
		instance.errors.full_messages.each_with_index do |message, index|
			flash["Error #{index+1}"] = message
		end
	end
end
