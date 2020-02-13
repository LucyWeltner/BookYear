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
	# def create
	# 	raise params.inspect
	# 	params[:listings].each_with_index do |book_info|
	# 		Listing.create(book_info["#{index}"].permit(:list_id, :book_id, :comments))
	# 	end
	# end 
end