Rails.application.routes.draw do
  devise_for :customers, controllers: {
    registrations: 'publics/registrations',
    sessions: 'publics/sessions',
    omniauth_callbacks: 'publics/omniauth_callbacks',
    passwords: 'publics/passwords',
  }

  devise_scope :customer do
    post 'customers/guest_sign_in' => 'publics/sessions#new_guest'
  end

  scope module: :publics do
    root 'homes#top'
    get 'oahu' => 'abouts#oahu', as: 'oahu'
    get 'kauai' => 'abouts#kauai', as: 'kauai'
    get 'molokai' => 'abouts#molokai', as: 'molokai'
    get 'maui' => 'abouts#maui', as: 'maui'
    get 'lanai' => 'abouts#lanai', as: 'lanai'
    get 'hawaii' => 'abouts#hawaii', as: 'hawaii'
    get 'question' => 'categorys#question', as: 'question'
    get 'sns' => 'categorys#sns', as: 'sns'
    get 'youtube' => 'categorys#youtube', as: 'youtube'
    get 'reference_links' => 'categorys#reference_links', as: 'reference_links' # 参考資料
    patch "/customers/withdraw" => "customers#withdraw", as: 'withdraw' # 退会ステータス用
    get 'inquiry' => 'inquiry#index', as: 'inquiry' # お問い合わせ
    post 'confirm' => 'inquiry#confirm', as: 'confirm'
    post 'thanks'  => 'inquiry#thanks', as: 'thanks'
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
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
  }

  devise_scope :admin do
    post 'admins/guest_sign_in' => 'admins/sessions#new_guest'
  end

  namespace :admins do
    get 'top' => 'homes#top', as: 'top'
    resources :admins, only: [:edit, :update, :destroy]
    resources :customers, only: [:index, :edit, :update, :destroy]
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :posts, only: [:index, :show, :edit, :update, :destroy]
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
