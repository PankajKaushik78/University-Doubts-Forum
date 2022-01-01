Rails.application.routes.draw do
  resources :categories
  
  resources :doubts do
    resources :comments
    resources :answers
    member do
      get :escalate
      get :accept
    end
  end

  get "/dashboard", to: "home#dashboard"
  get "/doubts/accept/:id", to: "doubt#accept"

  root 'doubts#index'
  
  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
end
