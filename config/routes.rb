Rails.application.routes.draw do

  get 'posts/index'
  get 'posts/edit'
  get 'posts/update'
  get 'posts/destroy'
  devise_for :customers, controllers: {
    registrations: 'publics/registrations',
    sessions: 'publics/sessions',
    omniauth_callbacks: 'publics/omniauth_callbacks'
  }

  devise_scope :customer do
    post 'customers/guest_sign_in' => 'publics/sessions#new_guest'
  end

  scope module: :publics do
    root 'homes#top'
    get 'about' => 'categorys#about', as: 'about'
    get 'category' => 'categorys#index', as: 'category'
    get 'question' => 'categorys#question', as: 'question'
    get 'sns' => 'categorys#sns', as: 'sns'
    get 'youtube' => 'categorys#youtube', as: 'youtube'
    resources :customers, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
  	  get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :posts, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    get 'search' => 'searchs#search'
  end


  devise_for :admins, controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions'
  }

  devise_scope :admin do
    post 'admins/guest_sign_in' => 'admins/sessions#new_guest'
  end

  namespace :admins do
    get 'top' => 'homes#top', as: 'top'
    resources :admins, only: [:edit, :update, :destroy]
    resources :customers, only: [:index, :edit, :update, :destroy]
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :posts, only: [:index, :edit, :update, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
