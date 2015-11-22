Rails.application.routes.draw do

  devise_for :admins, controllers: {registrations: 'registrations'}, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'user/edit'}
	resources :beers do 
		collection do 
			get 'search'
		end
		resources :reviews, except: [:show, :index]
		resource :like, module: :beers
	end	

	root 'splash#home'

end
