namespace :admin do
  resources :users, except: [:new, :create] do
    post 'resend_confirmation_email' => 'users#resend_confirmation_email', on: :member
    patch 'unlock' => 'users#unlock', on: :member
  end
  resources :actors
  resources :technics
  resources :materials
  resources :projects
  resources :regions
  resources :pages do 
    resources :blocks, controller: 'pages/blocks', except: :index
  end
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