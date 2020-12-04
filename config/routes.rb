Rails.application.routes.draw do
  devise_scope :user do
    root to: 'devise/registrations#new'
  end
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
  get '/login/', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get 'pages/index'
  get 'pages/show'
  # root to: 'expenses#index'
  get '/expenses/:select_date/:months', to: 'expenses#index'  
  resources :expenses
end
