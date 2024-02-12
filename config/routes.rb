Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: "users/confirmations",
    passwords: "users/passwords",
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  draw 'admin'

  scope "(:region_slug)", constraints: lambda { |request|
      region_slug = request.params[:region_slug]
      region_slug.blank? || Region.where(slug: region_slug).exists?
    } do
    resources :actors, path: 'ecosysteme', only: [:index, :show] do
      collection do
        get 'glossaire' => 'actors#options', as: :options
        get ':item_slug/:option_slug' => 'actors#option', as: :option
      end
    end
    resources :materials, path: 'materiaux', only: [:index, :show] do
      collection do
        get 'glossaire' => 'materials#options', as: :options
        get ':item_slug/:option_slug' => 'materials#option', as: :option
      end
    end
    resources :projects, path: 'projets', only: [:index, :show] do
      collection do
        get 'glossaire' => 'projects#options', as: :options
        get ':item_slug/:option_slug' => 'projects#option', as: :option
      end
    end
    resources :assemblies, path: 'assemblages', only: [:index, :show] do
      collection do
        get 'glossaire' => 'assemblies#options', as: :options
        get ':item_slug/:option_slug' => 'assemblies#option', as: :option
      end
    end
  end
  get 'regions' => 'regions#index', as: :regions
  resources :regions, path: "", only: :show

  get 'mon-compte/suivi' => 'favorites#index', as: :favorites
  put 'mon-compte/suivi' => 'favorites#create'
  delete 'mon-compte/suivi' => 'favorites#destroy'
  root to: 'home#index'
end
