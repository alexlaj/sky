Rails.application.routes.draw do
  root 'guild_members#index'

  resources :guild_members, only: [:index] do
    get 'resync', on: :collection
  end
end
