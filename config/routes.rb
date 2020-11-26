Rails.application.routes.draw do
  get 'categotys/question'
  get 'categotys/sns'
  get 'homes/top'
  devise_for :customers, controllers: {
    registrations: 'publics/registrations',
    sessions: 'publics/sessions'
  }

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
    sessions: 'admins/sessions'
  }

  namespace :admins do
    get 'top' => 'homes#top', as: 'top'
    resources :customers, only: [:index, :edit, :update, :destroy]
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
