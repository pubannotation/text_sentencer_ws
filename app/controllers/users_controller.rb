class UsersController < ApplicationController
	def show
		@user = User.friendly.find(params[:email])
		@configs = Config.where(user_id: @user.id)
	end
end
