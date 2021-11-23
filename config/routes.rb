Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    update: "users/update"
  }

  root to: 'homes#top'

  resources :users, only: [:show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    collection do
        get 'confirm'
        patch 'quit'
      end
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :posts do
    resource :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  get   'inquiry'         => 'inquiry#index'     # 入力画面
  post  'inquiry/confirm' => 'inquiry#confirm'   # 確認画面
  post  'inquiry/thanks'  => 'inquiry#thanks'    # 送信完了画面

  get '/search', to: 'searchs#search'  # 検索機能
end