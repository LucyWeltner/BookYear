class AuthorsController < ApplicationController
	def new 
		if is_logged_in?
			@author = Author.new
			render 'new'
		else
			flash[:alert] = "You cannot create new authors if you are not logged in."
			redirect_to root_path
		end
	end
	def create
		@author = Author.find_or_create_by(name: params[:author][:name])
		@author.bio = params[:author][:bio]
		if @author.save
			flash[:success] = "Author successfully created."
			redirect_to author_path(@author)
		else
			@errors = @author.errors.full_messages
			render 'new'
		end
	end
	def edit
		if is_logged_in?
			@author = find_object(params, "author")
			render 'edit'
		else
			flash[:alert] = "You cannot edit authors if you are not logged in."
			redirect_to root_path
		end
	end
	def update
		@author = find_object(params, "author")
		if @author.update(ok_params)
			flash[:success] = "Author successfully editted."
			redirect_to author_path(@author)
		else
			@author = author
			@errors = author.errors.full_messages
			render 'edit'
		end
	end
	def show
		if Author.find_by_id(params[:id])
			@author = find_object(params, "author")
		else
			flash[:alert] = "There is no author with that id."
			redirect_to homepage_path
		end
	end
	private
		def ok_params
			params.require(:author).permit(:name, :bio)
		end
	
end