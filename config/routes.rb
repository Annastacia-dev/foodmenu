Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }


  get 'home/index'
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#index"
  resources :restaurants do
    member { get :confirm_email }
    member { get :confirm}
    member { get :settings}

    resources :menus do
      resources :menu_categories do
        resources :menu_items
      end
    end
  end

  resources :templates, only: [:index, :show]
end
