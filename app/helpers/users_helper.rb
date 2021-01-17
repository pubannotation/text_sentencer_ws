module UsersHelper
	def user(user)
		link_to user.email, user_path(user)
	end
end
