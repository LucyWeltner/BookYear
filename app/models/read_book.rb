class ReadBook < ApplicationRecord
	validates :user_id, presence: true
	validates :book_id, presence: true
	validates :date_read, presence: true
	belongs_to :user
	belongs_to :book
end



# /\A(\d{1}|\d{2})\-(\d{1}|\d{2})\-\d{4}\z/
