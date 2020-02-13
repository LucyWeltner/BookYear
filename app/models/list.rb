class List < ApplicationRecord
	validates :user_id, presence: true
	#validate numericality of user ID
	belongs_to :user
	has_many :listings 
	has_many :books, through: :listings
	def self.my_lists(session)
		self.where(:user_id => session[:user_id])
	end
end
