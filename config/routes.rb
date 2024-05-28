Rails.application.routes.draw do
  resources :posts
  root 'posts#index'
  delete '/posts/:id', to: 'posts#destroy'
end
