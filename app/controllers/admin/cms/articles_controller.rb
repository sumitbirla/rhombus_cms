class Admin::Cms::ArticlesController < Admin::BaseController

  def index
    authorize Article.new

    @articles = Article.where(domain_id: cookies[:domain_id]).order(published_at: :desc)
    @articles = @articles.where("title LIKE '%#{params[:q]}%'") unless params[:q].nil?

    respond_to do |format|
      format.html { @articles = @articles.paginate(page: params[:page], per_page: @per_page) }
      format.csv { send_data Article.to_csv(@articles) }
    end
  end

  def new
    @article = authorize Article.new(title: 'New article', status: "draft")
    render 'edit'
  end

  def create
    @article = authorize Article.new(article_params)
    @article.domain_id = cookies[:domain_id]

    if @article.save
      redirect_to action: 'show', id: @article.id, notice: 'Article was successfully created.'
    else
      render 'edit'
    end
  end

  def show
    @article = authorize Article.find(params[:id])
  end

  def edit
    @article = authorize Article.find(params[:id])
  end

  def update
    @article = authorize Article.find(params[:id])

    if @article.update(article_params)
      Rails.cache.delete @article
      redirect_to action: 'show', id: @article.id, notice: 'Article was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @article = authorize Article.find(params[:id])
    @article.destroy

    Rails.cache.delete @article
    redirect_to action: 'index', notice: 'Article has been deleted.'
  end


  def pictures
    @article = Article.find(params[:id])
    authorize @article, :show?
    Rails.cache.delete @article
  end

  def categories
    @article = Article.includes(:categories).find(params[:id])
    authorize @article, :show?
  end

  def create_categories
    authorize Article, :update?

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
