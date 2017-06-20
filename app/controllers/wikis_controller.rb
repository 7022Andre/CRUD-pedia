class WikisController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

	def index
		@wikis = Wiki.all
	end

	def show
		@wiki = Wiki.find(params[:id])
		if @wiki.private
			authorize @wiki
		end
	end

	def new
		@wiki = Wiki.new
	end

	def create
		@wiki = Wiki.new(wiki_params)
		if @wiki.private
			authorize @wiki
		end
		@wiki.user = current_user

		if @wiki.save
			flash[:notice] = "Your wiki was saved."
			redirect_to [@wiki]
		else
			flash[:alert] = "There was an error saving your wiki. Please try again."
			render :new
		end
	end

	def edit
		@wiki = Wiki.includes(:collaborate_users).find(params[:id])
		if @wiki.private
			authorize @wiki
		end
		@users = User.where(role: "standard")
	end

	def update
		@wiki = Wiki.find(params[:id])
		@wiki.assign_attributes(wiki_params)
		if @wiki.private
			authorize @wiki
		end

		if @wiki.save
			flash[:notice] = "Your wiki was updated."
			redirect_to [@wiki]
		else
			flash[:alert] = "There was an error updating your wiki. Please try again."
			render :new
		end
	end

	def destroy
		@wiki = Wiki.find(params[:id])
		authorize @wiki

		if @wiki.destroy
			flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
			redirect_to action: :index
		else
			flash[:alert] = "There was an error deleting the wiki."
			render :show
		end
	end

	private

	def wiki_params
		params.require(:wiki).permit(:title, :body, :private)
	end

	private

	def user_not_authorized(exception)
		if exception.query == 'show?' || exception.query == 'create?' || exception.query == 'edit?'
  		flash[:alert] = "Please upgrade to a Premium membership to create, edit or read a private wiki."
  		redirect_to request.referer
  	else
  		flash[:alert] = "You are not authorized to perform this action."
  		redirect_to request.referer
  	end
  end
end
