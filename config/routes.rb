Rails.application.routes.draw do

  devise_for :admins
	resources :beers do 
		collection do 
			get 'search'
		end
		resources :reviews, except: [:show, :index]
	end	

	root 'splash#home'

end
