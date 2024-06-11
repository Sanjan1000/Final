Rails.application.routes.draw do
  get 'search', to: 'search#index'
  patch '/update_theme', to: 'application#update_theme'
  resources :tags
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    get '/admin/:id/block' => 'admin#block'
    get '/admin/:id/unblock' => 'admin#unblock'
    get '/admin/:id' => 'admin#destroy'
  end

  resources :posts do
    resources :nested_posts, only: [:new, :create, :edit, :update, :destroy, :show] do
      resources :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
  end

  resources :nested_posts, only: [] do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
    resources :tags, only: [:index, :show]
  end

  resources :admin, only: [:index, :update] do
    member do
      post :block
      post :unblock
    end
  end

  namespace :api do
    namespace :v1 do
      get 'posts/index'
      resources :posts, only: [:index]
    end
  end
  
  resources :posts, only: [] do
    member do
      get :generate_api_token
    end
  end

  get 'new_jira_issue', to: 'issues#new', as: 'new_jira_issue'
  post 'create_jira_issue', to: 'issues#create_jira_issue'
  root 'home#index'
  resources :admin, only: [:index, :update, :destroy]
end
