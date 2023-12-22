Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: "users/confirmations",
    passwords: "users/passwords",
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  draw 'admin'

  localized do
    scope "(:region_slug)", constraints: lambda { |request|
      region_slug = request.params[:region_slug]
      Region.where(slug: region_slug).exists?
    } do
      resources :materials, only: [:index, :show] do
        collection do
          get ':item_slug/:option_slug' => 'materials#option', as: :option
        end
      end
      resources :projects, only: [:index, :show] do
        collection do
          get ':item_slug/:option_slug' => 'projects#option', as: :option
        end
      end
    end
    get 'regions' => 'regions#index', as: :regions
    resources :regions, path: "", only: :show
  end

  root to: 'home#index'
end
