Rails.application.routes.draw do
  root 'dashboard#index'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  get '/dashboard', to: 'dashboard#index'
  
  # Admin routes
  get '/admin', to: 'admin#index', as: 'admin_index'
  get '/admin/users/:id/edit', to: 'admin#edit_user', as: 'admin_edit_user'
  patch '/admin/users/:id', to: 'admin#update_user', as: 'admin_update_user'
  
  resources :doc_as do
    member do
      post :approve
      post :reject
      post :forward
    end
  end
  
  resources :doc_bs do
    member do
      post :approve
      post :reject
    end
  end
end

