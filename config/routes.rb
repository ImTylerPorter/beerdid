Rails.application.routes.draw do

  resources :pages
  # , path: 'page', only: [:show, :edit]
 

  # %w[about privacy terms].each do |page|
  # 	get page, controller: "info", action: page
  # end

  devise_for :admins, controllers: {registrations: 'registrations'}, :path => 'profile', :path_names => {:sign_in => 'login', :sign_out => 'logout', :sign_up => "signup"}
	resources :beers do 
		collection do 
			get 'search'
		end
		resources :reviews, except: [:show, :index]
		resource :like, module: :beers
	end	

	root 'beers#index'

end
