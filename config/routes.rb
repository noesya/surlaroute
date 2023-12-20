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
        resources :items do
          collection do
            post :reorder
          end
        end
        resources :options do
          collection do
            post :reorder
          end
        end
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

  scope "(:region_slug)" do 
    resources :materials, path: "materiaux", only: [:index, :show]
    resources :projects, path: "projets", only: [:index, :show]
  end
  resources :regions, path: "regions", only: :index
  resources :regions, path: "", only: :show

  root to: 'home#index'
end
