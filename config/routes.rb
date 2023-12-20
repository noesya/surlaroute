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

  localized do
    # La contrainte ressemble à `region_slug: /(occitanie|ile-de-france)/`
    scope "(:region_slug)", constraints: { region_slug: Regexp.new(Region.pluck(:slug).join("|")) } do 
      resources :materials, only: [:index, :show]
      resources :projects, only: [:index, :show]
      # get ":resources_slug/:item_slug" => 'options#index', as: :options
      get ":resources_slug/:item_slug/:option_slug" => 'options#show', as: :option
    end
    resources :regions, only: :index
    resources :regions, path: "", only: :show
  end

  root to: 'home#index'
end
