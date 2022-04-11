class Admin::TargetAgesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @target_age = TargetAge.new
    @target_ages = TargetAge.all
  end

  def create
    @target_age = TargetAge.new(target_age_params)
    if @target_age.save
      redirect_to admin_target_ages_path(@target_age.id)
      flash[:notice] = "新しい対象年齢を登録しました。"
    else
      @target_ages = TargetAge.all
      render :index
      flash[:alert] = " 対象年齢を入力してください。"
    end
  end

  def edit
    @target_age = TargetAge.find(params[:id])
  end

  def update
     @target_age = TargetAge.find(params[:id])
     if @target_age.update(target_age_params)
      flash[:notice] = "対象年齢を編集しました。"
      redirect_to admin_target_ages_path(@target_age.id)
     else
      render :edit
      flash[:alert] = " 対象年齢を入力してください。"
     end
  end

  def destroy
   @target_age = TargetAge.find(params[:id])
   @target_age.destroy
   flash[:notice] = "対象年齢を削除しました。"
   redirect_to admin_target_ages_path
  end

private
  def target_age_params
    params.require(:target_age).permit(:target)
  end
end