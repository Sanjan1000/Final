Rails.application.routes.draw do
  resources :tags
  get 'admin/index'
  devise_for :users
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'
    get '/admin/:id/block' => 'admin#block'
    get '/admin/:id/unblock' => 'admin#unblock'
    get '/admin/:id' => 'admin#destroy'      
  end
  resources :posts do
    resources :tags
    resources :comments
    resources :nested_posts, only: [:new, :create, :edit, :update, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  resources :admin, only: [:index, :update] do
    member do
      post :block
      post :unblock
    end
  end
  root 'posts#index'
  resources :admin, only: [:index, :update, :destroy]
  

end
