Rails.application.routes.draw do
  root to: 'expenses#index'
  resources :expenses
end
