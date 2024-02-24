Rails.application.routes.draw do
  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'
  get 'home/index'
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#index"
  resources :restaurants do
    devise_for :users, controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions'
    }
    member { get :confirm_email }
    member { get :confirm}
    member { get :settings}
  end
end
