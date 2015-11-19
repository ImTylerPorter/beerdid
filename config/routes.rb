Rails.application.routes.draw do

  devise_for :admins
	resources :beers
	root 'splash#home'

end
