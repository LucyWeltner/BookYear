class Listing < ApplicationRecord
	belongs_to :book
	belongs_to :list
	def self.find_listing(book: book, list: list)
		self.where(book_id: book.id).where(list_id: list.id)[0]
	end
end
