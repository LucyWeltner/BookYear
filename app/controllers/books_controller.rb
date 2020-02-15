require 'pry'
class BooksController < ApplicationController
	def show
		@book = find_object(params, "book")
		if @book 
			if !ReadBook.read?(@book.id, session)
				@rb = ReadBook.new
				@read = false
			else
				@listing = Listing.new
				@read = true
			end
			render 'show'
		else 
			flash[:error] = "There is no book with that ID."
			redirect_to book_search_path
		end
	end
	def index
		if params[:author_id] && @author = Author.find_by_id(params[:author_id])
			@books = Book.authors_books(params[:author_id])
		elsif params[:user_id] && @user = User.find_by_id(params[:user_id])
			@books = Book.my_books(params)
		else 
			flash[:alert] = "There is no author or user with that ID."
			redirect_to homepage_path
		end 
	end
	def search
	end 
	def results
		@results = Book.results(params[:query])
	end
	def new 
		if is_logged_in?
			@book = Book.new
			if params[:author_id]
				@author = Author.find(params[:author_id])
			end 
			render 'new'
		else 
			flash[:alert] = "You can only create books if you are logged in."
			redirect_to root_path
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
			@book = book
			@errors = book.errors.full_messages
			render 'new'
		end
	end
	def edit 
		if is_logged_in?
			@book = find_object(params, "book")
			render 'edit'
		else
			flash[:alert] = "You can only edit books if you are logged in."
			redirect_to root_path
		end
	end
	def update 
		@book = find_object(params, "book")
		if @book.update(ok_params)
			flash[:success] = "#{@book.title} was successfully editted!"
			redirect_to book_path(@book)
		else
			@errors = @book.errors.full_messages
			render 'new'
		end
	end

	private
	def ok_params
		params.require(:book).permit(:title, :author_id, :blurb, :year_published, :cover_image_url, :author_name)
	end
end