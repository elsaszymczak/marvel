Rails.application.routes.draw do
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :events, except: [:edit, :update] do
    resources :characters, only: [ :create]
    resources :comics, only: [ :create]
  end

  resources :characters, only: [:index, :show, :destroy]
  resources :comics, only: [:index, :show, :destroy]
end
