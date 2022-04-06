class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  
  def index
  end

  def show
  end

  def edit
  end

  def unsubscribe
  end

  def withdraw
  end
  
  private

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) 
      flash[:notice] = 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
  
end
