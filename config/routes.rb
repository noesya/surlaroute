Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: "users/confirmations",
    passwords: "users/passwords",
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  draw 'admin'

  get 'le-lab/comment-nous-rejoindre' => 'offers#index', as: :offers
  get 'le-lab/les-membres' => 'members#index', as: :members
  get 'le-lab/les-membres/:id' => 'members#show', as: :member

  scope 'mon-compte' do
    get 'suivi' => 'favorites#index', as: :favorites
    put 'suivi' => 'favorites#create'
    delete 'suivi' => 'favorites#destroy'
    resources :comments, path: 'commentaires', as: :user_comments
  end


  scope "(:region_slug)", constraints: lambda { |request|
      region_slug = request.params[:region_slug]
      region_slug.blank? || Region.where(slug: region_slug).exists?
    } do
    resources :actors, path: 'ecosysteme', only: [:index, :show] do
      collection do
        get 'carte' => 'actors#index', as: :map, mode: 'map'
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
    resources :technics, path: 'techniques', only: [:index, :show] do
      collection do
        get 'glossaire' => 'technics#options', as: :options
        get ':item_slug/:option_slug' => 'technics#option', as: :option
      end
    end
  end
  get 'regions' => 'regions#index', as: :regions
  get '/:id' => 'regions#show', as: :region, constraints: lambda { |request|
    region_slug = request.params[:id]
    Region.where(slug: region_slug).exists?
  }

  match '*path', via: :all, to: 'pages#show', constraints: lambda { |req|
    Page.find_by(path: req.path[1..-1]).present?
  }

  get '/media/:signed_id/:filename_with_transformations' => 'media#show', as: :medium

  root to: 'home#index'
end
