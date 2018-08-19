Rails.application.routes.draw do
  namespace :admin do
    root to: 'dashboard#index'

    # sessions
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'

    resources :tag_groups
    resources :tags
    resources :categories
    resources :articles do
      member do
        patch :publish
        patch :unpublish
      end
    end
  end

  root to: 'articles#index'
  resources :articles, only: [:index, :show]
  resources :categories, only: [:show]
  resources :tags, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
