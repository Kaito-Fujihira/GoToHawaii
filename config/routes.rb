Rails.application.routes.draw do
  devise_for :customers, controllers: {
    registrations: 'publics/registrations',
    sessions: 'publics/sessions'
  }

  scope module: :publics do
    root 'homes#top'
    get 'about' => 'homes#about', as: 'about'
    resources :customers, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
    member do
      get :followings, :followers
    end
    end
    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end


  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  namespace :admins do
    get 'top' => 'homes#top', as: 'top'
    resources :customers, only: [:index, :edit, :update, :destroy]
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
