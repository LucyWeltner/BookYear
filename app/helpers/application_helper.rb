module ApplicationHelper
	def is_logged_in?
		!!session[:user_id]
	end
	# def read?(book_id)
	# 	found = ReadBook.find_by(book_id: book_id, user_id: session[:user_id])
	# 	if found 
	# 		return true
	# 	else 
	# 		return false 
	# 	end 
	# end

end
