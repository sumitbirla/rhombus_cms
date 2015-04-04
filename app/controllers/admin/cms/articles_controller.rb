class Admin::Cms::ArticlesController < Admin::BaseController
  
  def index
    @articles = Article.page(params[:page]).order(published_at: :desc)
    @articles = @articles.where("title LIKE '%#{params[:q]}%'") unless params[:q].nil?
  end

  def new
    @article = Article.new name: 'New article'
    render 'edit'
  end

  def create
    @article = Article.new(article_params)
    
    if @article.save
      redirect_to action: 'show', id: @article.id, notice: 'Article was successfully created.'
    else
      render 'edit'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    
    if @article.update(article_params)
      redirect_to action: 'show', id: @article.id, notice: 'Article was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to action: 'index', notice: 'Article has been deleted.'
  end
  
  
  def pictures
    @article = Article.find(params[:id])
  end
  
  def categories
    @article = Article.includes(:categories).find(params[:id])
  end
  
  def create_categories
    ArticleCategory.delete_all article_id: params[:id]
    category_ids = params[:category_ids]
    
    category_ids.each do |id|
      ArticleCategory.create article_id: params[:id], category_id: id
    end
    
    redirect_to action: 'show', id: params[:id], notice: 'Article was successfully updated.'
  end
  
  
  private
  
    def article_params
      params.require(:article).permit!
    end
  
  
end
