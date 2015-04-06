class ArticlesController < ApplicationController
  
  def index
    @articles = CmsCache.article_list
  end
  
  
  def show
    @article = CmsCache.article(params[:slug])
    if @article.nil?
      flash.now[:error] = "The article you are looking for was not found."
      return render 'error_page', status: 404 
    end
  end
  
end
