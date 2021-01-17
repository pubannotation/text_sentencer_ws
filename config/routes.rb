Rails.application.routes.draw do
	# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'sentencer#annotation'

  devise_for :users
  get '/users/:email' => 'users#show', :constraints => { :email => /.+@.+\..*/ }, as: 'user'

	resources :configs

  get  '/annotation' => 'sentencer#annotation'
  post '/annotation' => 'sentencer#annotation'
end
