Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'

  root to: "home#index"

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }

  get 'home/index'
  get "up" => "rails/health#show", as: :rails_health_check
  get "restaurant/:id/admin" => "restaurants#admin", as: :restaurant_admin

  resources :restaurants do
    member { get :confirm_email }
    member { get :confirm}
    member { get :locations}
    member { get :settings}
    member { get :new_location}

    resources :menus do
      resources :menu_categories do
        member { post :add_subcategory }
        member {patch :update_subcategory}
        member {delete :delete_subcategory}
        resources :menu_items
      end
    end

    resources :sub_restaurants do
      resources :menus do
        resources :menu_categories do
          member { post :add_subcategory }
          member {patch :update_subcategory}
          member {delete :delete_subcategory}
          resources :menu_items
        end
      end

      member { get :new_location }
      member { get :locations}
    end
  end
  resources :layouts
  resources :locations

  get '/:id', to: 'restaurants#show', as: :restaurant_show
end
