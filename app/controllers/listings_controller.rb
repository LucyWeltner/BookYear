class ListingsController < ApplicationController
	def create
		listing = Listing.new(params.require(:listing).permit(:comments, :list_id, :book_id))
		if listing.save
			redirect_to list_path(params[:listing][:list_id])
		else
			make_errors(listing)
			redirect_to book_path(params[:book_id])
		end
	end
end