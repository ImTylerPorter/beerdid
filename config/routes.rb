Rails.application.routes.draw do

  devise_for :admins, controllers: {registrations: 'registrations'}
	resources :beers do 
		collection do 
			get 'search'
		end
		resources :reviews, except: [:show, :index]
	end	

	root 'splash#home'

end
