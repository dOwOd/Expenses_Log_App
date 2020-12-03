Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  root to: 'expenses#index'
  resources :expenses
  get '/expenses/:select_date/:months', to: 'expenses#index'
end
