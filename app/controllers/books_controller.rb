require 'pry'
class BooksController < ApplicationController
	def show
		@book = find_object(params, "book")
		@rb = ReadBook.new
		if @book 
			render 'show'
		else 
			flash[:message] = "There is no book with that ID."
			redirect_to books_search_path
		end
	end
	def index
		if params[:author_id] && @author = Author.find_by_id(params[:author_id])
			@books = Book.authors_books(params[:author_id])
		elsif params[:user_id] && @user = User.find_by_id(params[:user_id])
			@books = Book.my_books(params)
		else 
			flash[:alert] = "There is no author or user with that ID."
		end 
	end
	def search
	end 
	def results
		@results = Book.results(params[:query])
	end
	def new 
		@book = Book.new
		if params[:author_id]
			@author = Author.find(params[:author_id])
		end 
	end 
	def create
		book = Book.new(ok_params)
		if params[:author_id]
			book.author_id = params[:author_id]
		end
		if book.save
			redirect_to book_path(book)
		else
			make_errors(book)
			redirect_to new_book_path
		end
	end
	private
	def ok_params
		params.require(:book).permit(:title, :author_id, :blurb, :year_published, :cover_image_url, :author_name)
	end
end