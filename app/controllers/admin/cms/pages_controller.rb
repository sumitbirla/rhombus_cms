class Admin::Cms::PagesController < Admin::BaseController
  
  def index
    @pages = Page.where(domain_id: cookies[:domain_id]).order(:title)
    
    respond_to do |format|
      format.html  { @pages = @pages.paginate(page: params[:page], per_page: @per_page) }
      format.csv { send_data Page.to_csv(@pages) }
    end
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
      params.require(:page).permit!
    end
  
end
