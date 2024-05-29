Rails.application.routes.draw do
  get 'admin/index'
  devise_for :users
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'
    get '/admin/:id' => 'admin#destroy'     
  end
  resources :posts do
    resources :comments
    resources :nested_posts, only: [:new, :create]
  end
  root 'posts#index'
  resources :admin, only: [:index, :update, :destroy]
  

end
