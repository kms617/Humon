Rails.application.routes.draw do

  root 'sessions#create'

  scope module: :api, defaults: { format: 'json' } do
    namespace :v1 do
      namespace :events do
        resources :nearests, only: [:index]
      end

      resources :events, only: [:create, :show, :update]
    end

    resources :users, only: [:create]
    resources :sessions, only: [:create]
  end
end
