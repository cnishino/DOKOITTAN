class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		@genre_id = params[:genre_id]
		@prefecture = params[:prefecture]
		if @model == 'user'
			@records = User.search_for(@content, @method)
		else
			@records = PostLocation.search_for(@content, @method,@genre_id ,@prefecture)
		end
	end
end
