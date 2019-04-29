class Admin::Cms::MenusController < Admin::BaseController
  
  def index
    authorize Menu.new
    @menus = Menu.where(domain_id: cookies[:domain_id]).all
  end

  def new
    @menu = authorize Menu.new(title: 'New menu')
    render 'edit'
  end

  def create
    @menu = authorize Menu.new(menu_params)
    @menu.domain_id = cookies[:domain_id]
    
    if @menu.save
      redirect_to action: 'index', notice: 'Menu was successfully created.'
    else
      render 'edit'
    end
  end

  def show
    @menu = authorize Menu.find(params[:id])
  end

  def edit
    @menu = authorize Menu.find(params[:id])
  end

  def update
    @menu = authorize Menu.find(params[:id])
    
    if @menu.update(menu_params)
      Rails.cache.delete @menu
      redirect_to action: 'index', notice: 'Menu was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @menu = authorize Menu.find(params[:id])
    @menu.destroy
    
    Rails.cache.delete @menu
    redirect_back(fallback_location: admin_root_path), notice: 'Menu has been deleted.'
  end
  
  
  private
  
    def menu_params
      params.require(:menu).permit(:title, :key, :css_class, :notes)
    end
  
end
