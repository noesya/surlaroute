Rails.application.routes.draw do
  namespace :admin do
    resources :users, except: [:new, :create] do
      post 'resend_confirmation_email' => 'users#resend_confirmation_email', on: :member
      patch 'unlock' => 'users#unlock', on: :member
    end
    resources :materials
    resources :projects
    resources :regions
    namespace :structure do
      scope ':about_class' do 
        resources :items
      end
    end
    root to: "dashboard#index"
  end

  devise_for :users, controllers: {
    confirmations: "users/confirmations",
    passwords: "users/passwords",
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  resources :materials, path: "materiaux", only: [:index, :show], param: :slug
  resources :projects, path: "projets", only: [:index, :show], param: :slug
  resources :regions, path: "regions", only: [:index, :show], param: :slug
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  root to: 'home#index'
end
