Rails.application.routes.draw do
  resources :tags
  get 'admin/index'
  devise_for :users
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'
    get '/admin/:id' => 'admin#destroy'     
  end
  resources :posts do
    resources :tags
    resources :comments
    resources :nested_posts, only: [:new, :create, :edit, :update, :destroy]
    resources :likes, only: [:create, :destroy]
  end
  root 'posts#index'
  resources :admin, only: [:index, :update, :destroy]
  

end
