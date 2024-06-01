Rails.application.routes.draw do
  get 'search', to: 'search#index'

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

  root 'home#index'
  resources :admin, only: [:index, :update, :destroy]
end
