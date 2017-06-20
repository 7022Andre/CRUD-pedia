class CollaboratorsController < ApplicationController
	before_action :authenticate_user!

  def create
  	@collaborator = @wiki.collaborators.build(user_id: user.id)

		if @collaborator.save
			flash[:notice] = "Access was granted successfully."
		else
			flash[:alert] = "There was an error granting access. Please try again."
		end
		redirect_to edit_wiki_path
  end

  def destroy

  end
end