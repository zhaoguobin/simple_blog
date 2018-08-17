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
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
