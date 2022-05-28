Rails.application.routes.draw do

  # 会員用

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :user do #ゲストログイン
    get 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: "public" do #URLは指定のパス（publicが入らない）,ファイル構成変えない
    root to: 'homes#top'
    get  "/post_location/form" => "post_locations#form"
    post "/post_location/form" => "post_locations#create"
    get "/mypage" => "users#mypage" #会員情報詳細ページ（マイページ）表示
    get "/users/unsubscribe" => "users#unsubscribe" #退会確認画面の表示
    patch "/users/withdraw" => "users#withdraw" #退会フラグを切り替える
    get "/search" => "searches#search", as: "search" #検索

    resources :users, only: [:index,:show,:edit,:update] do#会員機能
      resource :relationships, only: [:create,:destroy] #フォロー・フォロワー機能
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
      member do
        get 'favorites'
      end
      get "search", to: "users#search"
    end

    resources :groups do
      get "join" => "groups#join"
    end

    resources :post_locations, only: [:index,:show,:edit,:create,:destroy,:update] do #投稿機能
      resources :post_comments, only: [:create, :destroy] #コメント機能
      resource :favorites, only: [:index, :create,:destroy] #いいね機能
      collection do
      get 'confirm'
      end
    end
end

  # 管理者用

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do #URLとファイル構成共に指定のパス
    get 'top' => 'homes#top', as: 'top'
    get "/search" => "searches#search", as: "search" #検索窓表示
    post "/search" => "searches#search_data", as: "search_data" #検索機能
    resources :users, only: [:index, :show, :edit, :update] #会員管理
    resources :genres, only: [:index, :create, :edit, :update, :destroy] #ジャンル登録
    resources :target_ages, only: [:index, :create, :edit, :update, :destroy] #対象年齢登録
    resources :post_locations, only: [:index, :show, :destroy] do #投稿管理
      resources :post_comments, only: [:create, :destroy] #コメント機能
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
