class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

	def search
		@model = params[:model]#会員検索か投稿検索
		prefecture = params[:prefecture] #検索条件に都道府県が入っている時
		genre_name = params[:genre_id].present? ? Genre.find(params[:genre_id]).name : "" #検索条件にジャンルIDが入っている時にgenre_idのnameを出して、検索条件：""に入れる
		content = "" #キーワード検索窓に何も入っていない時

		if prefecture.present? && genre_name.present? #検索条件に都道府県・ジャンルが共に存在する時、ビューページの検索条件：""にprefectureとgenre_nameを入れる
			content = "#{prefecture}&#{genre_name}"
		elsif prefecture.present? && genre_name.empty? #検索条件に都道府県存在する・ジャンル存在しない時、検索条件：""にprefectureを入れる
			content = prefecture
		elsif genre_name.present? && prefecture.empty? #検索条件に都道府県存在しない・ジャンル存在する時に、検索条件：""にgenre_nameを入れる
			content = genre_name
		end

		@content = params[:model].present? ? params[:content] : content #キーワード検索で会員・投稿の選択をしている時はモデルの情報、ない時はcontentの情報を入れる
		@method = params[:method]
		if @model == 'user' #会員のキーワード検索
			@records = User.search_for(params[:content], @method).page(params[:page]).per(6)
		elsif @model == 'post_location' #投稿のキーワード検索
			@records = PostLocation.search_for(params[:content], @method).page(params[:page]).per(6)
		else #会員・投稿どちらも選択していない場合（絞り込み検索）
			@records = PostLocation.search_tag(params[:genre_id],params[:prefecture])#.page(params[:page]).per(6)
      @records = Kaminari.paginate_array(@records).page(params[:page]).per(6)
		end

	end
end
