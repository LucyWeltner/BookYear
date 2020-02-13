class ListingsController < ApplicationController

	def create
		params[:listings].each do |book_info|
			Listing.create(:book_id => book_info[:book_id], :list_id => list.id, :comments => book_info[1])
		end
	end 
end