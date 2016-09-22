class Admin::Cms::ArticlesController < Admin::BaseController
  
  def index
    @articles = Article.where(domain_id: cookies[:domain_id]).order(published_at: :desc)
    @articles = @articles.where("title LIKE '%#{params[:q]}%'") unless params[:q].nil?
    
    respond_to do |format|
      format.html  { @articles = @articles.paginate(page: params[:page], per_page: @per_page) }
      format.csv { send_data Article.to_csv(@articles) }
    end
  end

  def new
    @article = Article.new title: 'New article', status: "draft"
    render 'edit'
  end

  def create
    @article = Article.new(article_params)
    @article.domain_id = cookies[:domain_id]
    
    if @article.save
      @article.save_tags(params[:tags].split(",").map { |x| x.strip.downcase })
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
      @article.save_tags(params[:tags].split(",").map { |x| x.strip.downcase })
      
      Rails.cache.delete @article
      redirect_to action: 'show', id: @article.id, notice: 'Article was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    
    Rails.cache.delete @article
    redirect_to action: 'index', notice: 'Article has been deleted.'
  end
  
  
  def pictures
    @article = Article.find(params[:id])
    Rails.cache.delete @article
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
    
    Rails.cache.delete @article
    redirect_to action: 'show', id: params[:id], notice: 'Article was successfully updated.'
  end
  
  
  private
  
    def article_params
      params.require(:article).permit!
    end
  
  
end
