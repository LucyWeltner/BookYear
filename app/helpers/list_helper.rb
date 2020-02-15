module ListHelper 
	def your_list?(list)
		if list.user.id == session[:user_id]
			return link_to 'Edit This List', edit_list_path(@list.id)
		end
	end
end