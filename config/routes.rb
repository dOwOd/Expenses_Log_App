Rails.application.routes.draw do
  get 'howtouse/index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  delete '/expenses/:id', to: 'expenses#destroy', as: :destroy_expenses

  resources :users
  delete '/users/:group_id/:user_id', to: 'users#destroy', as: :remove
  root to: 'expenses#index'
  resources :expenses do
    collection do
      get "auto_complete" 
    end 
  end
  get '/expenses/:group_id/:select_date', to: 'expenses#index', as: :expenses_list
  resources :groups do
    resources :groups_users, only: [:new, :create, :edit, :update]
  end 
  resources :invitations
  resources :user_settings do
    resources :user_collection do 
      collection do
        post 'save'
      end
    end
  end
end
