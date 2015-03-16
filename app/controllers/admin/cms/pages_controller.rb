class Admin::Cms::PagesController < Admin::BaseController
  
  def index
    @pages = Page.where(domain_id: cookies[:domain_id]).page(params[:page]).order(:title)
  end

  def new
    @page = Page.new title: 'New page'
    render 'edit'
  end

  def create
    @page = Page.new(page_params)
    @page.domain_id = cookies[:domain_id]
    
    if @page.save
      redirect_to action: 'index', notice: 'Page was successfully created.'
    else
      render 'edit'
    end
  end

  def show
    @page = Page.find(params[:id])
  end

  def edit
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    
    if @page.update(page_params)
      Rails.cache.delete @page
      redirect_to action: 'index', notice: 'Page was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    
    Rails.cache.delete @page
    redirect_to :back, notice: 'Page has been deleted.'
  end
  
  
  private
  
    def page_params
      params.require(:page).permit(:title, :slug, :published, :header_content, :body)
    end
  
end
