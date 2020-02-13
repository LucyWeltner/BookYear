require 'pry'
class ListsController < ApplicationController 
	def new 
		@list = List.new
		@books = Book.my_books(session)
	end 
	# def add_books
	# 	@list = find_object(params, "list")
	# 	@books = Book.my_books(session)
	# end
	def create
		list = List.new(ok_params)
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

	private
	def ok_params
		params.require(:list).permit(:name, :user_id, :book_ids =>[])
	end
end
