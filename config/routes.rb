Rails.application.routes.draw do
  devise_for :users, controllers: {
    confirmations: "users/confirmations",
    passwords: "users/passwords",
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  draw 'admin'

  localized do
    # La contrainte ressemble à `region_slug: /(occitanie|ile-de-france)/`
    scope "(:region_slug)", constraints: { region_slug: Regexp.new(Region.pluck(:slug).join("|")) } do 
      resources :materials, only: [:index, :show] do
        collection do
          get ':item_slug/:option_slug' => 'materials#option', as: :option
        end
      end
      resources :projects, only: [:index, :show]
      # materiaux/aspect/mat
      # projets/categorie/maitre-d-oeuvre
      get ":resources_slug/:item_slug/:option_slug" => 'options#show', as: :option
    end
    get 'regions' => 'regions#index', as: :regions
    resources :regions, path: "", only: :show
  end

  root to: 'home#index'
end
