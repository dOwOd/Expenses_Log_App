Rails.application.routes.draw do
  devise_for :users, controllers: { :omniauth_callbacks => "omniauth_callbacks" }
  root to: 'expenses#index'
  resources :expenses
  get '/expenses/:select_date/:months', to: 'expenses#index'
end
