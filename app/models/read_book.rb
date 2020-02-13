class ReadBook < ApplicationRecord
	validates :user_id, presence: true
	validates :book_id, presence: true, uniqueness: {scope: :user_id, message: "You have already read this book."}
	validates :date_read, presence: true
	belongs_to :user
	belongs_to :book
	def self.read?(book_id, session)
		found = ReadBook.find_by(book_id: book_id, user_id: session[:user_id])
		if found 
			return true
		else 
			return false 
		end 
	end
end



# /\A(\d{1}|\d{2})\-(\d{1}|\d{2})\-\d{4}\z/
