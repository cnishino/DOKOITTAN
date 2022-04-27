class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genre = Genre.new
    @genres = Genre.all.page(params[:page]).per(8)
    # @genres = Kaminari.paginate_array(@genres).page(params[:page]).per(8)
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
    redirect_to admin_genres_path(@genre.id)
    flash[:notice] = "新しいジャンルを登録しました。"
    else
      @genre = Genre.new
      @genres = Genre.all
      @genres = Kaminari.paginate_array(@genres).page(params[:page]).per(8)
      flash.now[:alert] = " ジャンル名を入力してください。"
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
     @genre = Genre.find(params[:id])
     if @genre.update(genre_params)
      flash[:notice] = "ジャンルを編集しました。"
      redirect_to admin_genres_path(@genre.id)
     else
      flash.now[:alert] = " ジャンル名を入力してください。"
      render :edit
     end
  end

  def destroy
   @genre = Genre.find(params[:id])
   @genre.destroy
   flash[:notice] = "ジャンルを削除しました。"
   redirect_to admin_genres_path(@genre.id)
  end

private
  def genre_params
    params.require(:genre).permit(:name)
  end
end
