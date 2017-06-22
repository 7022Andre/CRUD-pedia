class CollaboratorsController < ApplicationController
	before_action :authenticate_user!

  def create
    authorize Collaborator
  	wiki = Wiki.find(params[:wiki_id])
  	user = User.find(params[:user_id])

  	collaborator = wiki.collaborators.build(user_id: params[:user_id])

		if collaborator.save
			flash[:notice] = "Access successfully granted to \"#{user.email}\"."
		else
			flash[:alert] = "There was an error granting access. Please try again."
		end
		redirect_to edit_wiki_path(params[:wiki_id])
  end

  def destroy
    authorize Collaborator
  	wiki = Wiki.find(params[:wiki_id])
  	user = User.find(params[:user_id])
    
  	collaborator = wiki.collaborators.find_by(user_id: params[:user_id])

  	if collaborator.destroy
  		flash[:notice] = "Access to this wiki has been revoked for user \"#{user.email}\"."
  	else
  		flash[:alert] = "There was an error revoking access. Please try again."
  	end
  	redirect_to edit_wiki_path(params[:wiki_id])
  end
end
