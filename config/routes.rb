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

  get   'inquiries'         => 'inquiries#index'     # 入力画面
  post  'inquiries/confirm' => 'inquiries#confirm'   # 確認画面
  post  'inquiries/thanks'  => 'inquiries#thanks'    # 送信完了画面

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
