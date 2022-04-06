Rails.application.routes.draw do

  # 会員用
  # URL /users/sign_in ...
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :user do #ゲストログイン
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: "public" do #URLは指定のパス（publicが入らない）,ファイル構成変えない
    root to: 'homes#top'
    get 'about' => 'homes#about', as: 'about'
    get  "/users/sign_out" => "sessions#destroy"
    get "/users/my_page" => "users#show" #会員情報詳細ページ（マイページ）表示
    get "/users/unsubscribe" => "users#unsubscribe" #退会確認画面の表示
    patch "/users/withdraw" => "users#withdraw" #退会フラグを切り替える
    get "/search" => "searches#search", as: "search" #検索窓表示
    post "/search" => "searches#search_data", as: "search_data" #検索機能

    resources :users, only: [:index,:edit,:update] #会員機能
    resources :post_locations, only: [:index,:show,:edit,:create,:destroy,:update] do #投稿機能
      resources :post_comments, only: [:create, :destroy] #コメント機能
      resource :favorites, only: [:create, :destroy] #いいね機能
    end

    resources :users, only: [:index,:show,:edit,:update] do #フォロー・フォロワー機能
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end

  end



  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do #URLとファイル構成共に指定のパス
    get 'top' => 'homes#top', as: 'top'
    get "/search" => "searches#search", as: "search" #検索窓表示
    post "/search" => "searches#search_data", as: "search_data" #検索機能
    resources :users, only: [:index, :show, :edit, :update] #会員機能
    resources :genres, only: [:index, :create, :edit, :update] #ジャンル機能
    resources :prefectures, only: [:index, :create, :edit, :update] #都道府県別
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
