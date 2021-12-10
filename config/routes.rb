Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      resources :items

      resources :merchants do
        resources :items, module: :merchants
        end

        resources :items do
          resources :merchant, module: :items, only: [:index]
        end
      end
    end
  end
