Rails.application.routes.draw do
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'


  resources :users, except: [:index, :edit, :show] 
  # put this below resources :users
  get '/users/:username', to: 'users#show', as: 'username'
  get '/follow/:id', to: 'users#follow', as: 'follow_user'
  get '/unfollow/:id', to: 'users#unfollow', as: 'unfollow_user'
  get '/profile', to: 'users#profile', as: 'profile'
  get '/profile/edit', to: 'users#edit', as: 'edit_profile'
  get '/profile/edit/password', to: 'users#password', as: 'edit_password'
  get '/profile/close', to: 'users#close', as: 'close_profile'
  resources :posts
  root 'posts#index'
end
