class ListsController < ApplicationController 
	def new 
		@list = List.new
	end 
	def add_books
		@list = find_object(params, "list")
		@books = Book.my_books(session)
	end
	def create
		list = List.new(ok_params)
		if list.save
			redirect_to add_books_path(list)
		end
	end
	def index
		@lists = List.my_lists(session)
	end
	def show
		@list = find_object(params, "list")
	end

	private
	def ok_params
		params.require(:list).permit(:name, :user_id)
	end
end
