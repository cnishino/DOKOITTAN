class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

	def search
		@model = params[:model]
		prefecture = params[:prefecture]
		genre_name = params[:genre_id].present? ? Genre.find(params[:genre_id]).name : ""
		content = ""
		if prefecture.present? && genre_name.present?
			content = "#{prefecture}&#{genre_name}"
		elsif prefecture.present? && genre_name.empty?
			content = prefecture
		elsif genre_name.present? && prefecture.empty?
			content = genre_name
		end
		@content = params[:model].present? ? params[:content] : content
		@method = params[:method]
		if @model == 'user'
			@records = User.search_for(params[:content], @method)
		elsif @model == 'post_location'
			@records = PostLocation.search_for(params[:content], @method)
		else
			@records = PostLocation.search_tag(params[:genre_id],params[:prefecture])
		end
	end
end
