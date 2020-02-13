class AuthorsController < ApplicationController
	def show
		if Author.find_by_id(params[:id])
			@author = find_object(params, "author")
		else
			flash[:alert] = "There is no author with that id."
			redirect_to homepage_path
		end
	end
end