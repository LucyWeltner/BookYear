require 'pry'
class ReadBooksController < ApplicationController
	def create
		rb = ReadBook.new(book_id: params[:read_book][:book_id].to_i, user_id: current_user.id, date_read: make_date(params[:read_book]["date_read(3i)"], params[:read_book]["date_read(2i)"], params[:read_book]["date_read(1i)"]))
		if rb.save
			flash[:success] = "#{Book.find(rb.book_id).title} has been added to your read books!"
			redirect_to book_path(Book.find(rb.book_id))
		else
			make_errors(rb)
			redirect_to book_path(Book.find(rb.book_id))
		end
	end
	private

	def make_date(day, month, year)
		"#{day}/#{month}/#{year}"
	end
end