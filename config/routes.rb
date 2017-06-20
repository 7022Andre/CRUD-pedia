Rails.application.routes.draw do
	resources :wikis do
		resources :collaborators, only: [:create, :destroy]
	end

	resources :charges, only: [:new, :create]
	devise_for :users
	resources :users, only: [:show, :update]
	#resources :collaborators, only: [:create, :destroy]
  
  root 'welcome#index'
end
