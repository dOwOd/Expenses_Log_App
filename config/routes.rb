Rails.application.routes.draw do
  root to: 'expenses#index'
  resources :expenses
  get '/expenses/:select_date/:months', to: 'expenses#index'
end
