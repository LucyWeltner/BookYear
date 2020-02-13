class User < ApplicationRecord
	has_secure_password
	has_many :lists
	has_many :read_books
	has_many :books, through: :read_books
	has_many :listed_books, through: :lists, source: :books
	validates :username, presence: true, uniqueness: true
end
