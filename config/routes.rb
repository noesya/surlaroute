Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: "users/confirmations",
    passwords: "users/passwords",
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  get 'le-lab/comment-nous-rejoindre' => 'offers#index', as: :offers

  scope 'mon-compte' do
    get 'suivi' => 'favorites#index', as: :favorites
    put 'suivi' => 'favorites#create'
    delete 'suivi' => 'favorites#destroy'
    resources :comments, path: 'commentaires', as: :user_comments
  end

  # TODO: ca ne restera pas comme ça
  get 'le-lab/les-membres/:member' => 'members#show', as: :member

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
    resources :technics, path: 'techniques', only: [:index, :show] do
      collection do
        get 'glossaire' => 'technics#options', as: :options
        get ':item_slug/:option_slug' => 'technics#option', as: :option
      end
    end
    get '' => 'regions#show', as: :region
  end
  get 'regions' => 'regions#index', as: :regions

  match '*path', via: :all, to: 'pages#show', constraints: lambda { |req|
    Page.find_by(path: req.path[1..-1]).present?
  }

  root to: 'home#index'
end
