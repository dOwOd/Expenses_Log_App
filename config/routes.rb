Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users
  delete '/users/:group_id/:user_id', to: 'users#destroy', as: :remove
  root to: 'expenses#index'
  resources :expenses do
    collection do
      get "auto_complete" 
    end 
  end
  get '/expenses/:select_date/:months', to: 'expenses#index'
  resources :groups do
    resources :groups_users, only: [:new, :create, :edit, :update]
  end 
  resources :invitations
  resources :user_settings
end
