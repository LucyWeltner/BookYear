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
	def search
	end 
	def results
		@results = Book.results(params[:query])
	end
	def new 
		@book = Book.new
	end 
	def create
		book = Book.new(ok_params)
		if book.save
			redirect_to book_path(book)
		else
			book.errors.full_messages.each_with_index do |message, index|
				flash["Error #{index+1}"] = message
			end
			redirect_to new_book_path
		end
	end
	private
	def ok_params
		params.require(:book).permit(:title, :author_id, :blurb, :year_published, :cover_image_url, :author_name)
	end
end