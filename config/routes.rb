Rails.application.routes.draw do
  root 'members#index'

  resources :members do
    get 'resync', on: :collection
  end
end
