class Admin::PrefecturesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @prefecture = Prefecture.new
    @prefectures = Prefecture.all
  end

  def create
    @prefecture = Prefecture.new(prefecture_params)
    if @prefecture.save
      redirect_to admin_prefectures_path(@prefecture.id)
      flash[:notice] = "新しい都道府県を登録しました。"
    else
      @prefectures = Prefecture.all
      render :index
      flash[:alert] = " 都道府県名を入力してください。"
    end
  end

  def edit
    @prefecture = Prefecture.find(params[:id])
  end

  def update
     @prefecture = Prefecture.find(params[:id])
     if @prefecture.update(prefecture_params)
      flash[:notice] = "都道府県を編集しました。"
      redirect_to admin_prefectures_path(@prefecture.id)
     else
      render :edit
      flash[:alert] = " 都道府県名を入力してください。"
     end
  end

  def destroy
   @prefecture = Prefecture.find(params[:id])
   @prefecture.destroy
   flash[:notice] = "都道府県を削除しました。"
   redirect_to admin_prefectures_path
  end

private
  def prefecture_params
    params.require(:prefecture).permit(:name)
  end
end
