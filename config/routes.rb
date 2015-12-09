Rails.application.routes.draw do

  get 'page_view/show', path: 'bob', controller: :page_view, action: :show

    # page_view ':name', controller: :page_view, action: :show


  resources :pages

  # , path: '(.:format)', except: [:index, :new]
 

  # %w[about privacy terms].each do |page|
  # 	get page, controller: "info", action: page
  # end

  devise_for :admins, controllers: {registrations: 'registrations'}, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'user/edit'}
	resources :beers do 
		collection do 
			get 'search'
		end
		resources :reviews, except: [:show, :index]
		resource :like, module: :beers
	end	

	root 'beers#index'

end
