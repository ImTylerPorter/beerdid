Rails.application.routes.draw do

  resources :reviews
  devise_for :admins
	resources :beers
	root 'splash#home'

end
