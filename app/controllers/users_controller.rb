class UsersController < ApplicationController
	before_action :authenticate_user!

	def show
		@user = User.find(params[:id])
		authorize @user
	end

	def update
		authorize current_user
		current_user.standard!
		redirect_to user_path(current_user)
	end
end
