class ArticlesController < ApplicationController
  
  def show
    @article = CmsCache.article(params[:slug])
  end
  
end
