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

  resources :restaurants do
    member { get :confirm_email }
    member { get :confirm}
    member { get :settings}

    resources :menus do
      resources :menu_categories do
        member { post :add_subcategory }
        member {patch :update_subcategory}
        member {delete :delete_subcategory}
        resources :menu_items
      end
    end
  end
  resources :layouts

  get '/:id', to: 'restaurants#show', as: :restaurant_show
end
