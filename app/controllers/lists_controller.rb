require 'pry'
class ListsController < ApplicationController 
	def new 
		if is_logged_in?
			@list = List.new
			@books = Book.my_books(session)
		else
			flash[:alert] = "Only logged in users can create lists."
			redirect_to root_path
		end

	end 
	def create
		list = List.new(ok_params)
		list.user_id = session[:user_id]
		if list.save
			redirect_to list_path(list.id)
		else 
			make_errors(list)
			redirect_to new_list_path
		end
	end
	def index
		@lists = List.my_lists(session)
	end
	def show
		@list = find_object(params, "list")
	end
	def edit
		@list = find_object(params, "list")
		if current_user == @list.user
			@books = Book.my_books(session)
			render 'edit'
		else
			flash[:alert] = "You cannot edit a list you did not create"
			redirect_to list_path(@list)
		end
	end
	def update
		@list = find_object(params, "list")
		if @list.update(ok_params)
			redirect_to list_path(@list)
		else
			make_errors(@list)
			redirect_to edit_list_path
		end
	end

	private
	def ok_params
		params.require(:list).permit(:name, :book_ids =>[])
	end
end
