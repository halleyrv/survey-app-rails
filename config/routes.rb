Rails.application.routes.draw do
  resources :chapters
  resources :evaluations
  devise_for :users

  authenticated(:user) do
    root 'pages#index', as: :authenticated_root
  end

  unauthenticated(:user) do 
    root 'pages#landing_page'
  end
  #root 'index#landing_page'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
