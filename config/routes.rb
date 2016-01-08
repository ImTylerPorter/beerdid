Rails.application.routes.draw do

 

  # %w[about privacy terms].each do |page|
  # 	get page, controller: "info", action: page
  # end

  devise_for :admins, 
  	controllers: {registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks'}, 
  	:path => 'profile', 
  	:path_names => {:sign_in => 'login', 
  					:sign_out => 'logout', 
  					:sign_up => "signup"}
	resources :beers do 
		collection do 
			get 'search'
		end
		resources :reviews, except: [:show, :index]
		resource :like, module: :beers
	end	

  get "sitemap" => "beers#sitemap"

	root 'beers#index'
  resources :pages
  get '*path' => redirect('/')

end
