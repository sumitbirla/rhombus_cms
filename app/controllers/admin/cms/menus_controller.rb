class Admin::Cms::MenusController < Admin::BaseController
  
  def index
    @menus = Menu.all
  end

  def new
    @menu = Menu.new title: 'New menu'
    render 'edit'
  end

  def create
    @menu = Menu.new(menu_params)
    
    if @menu.save
      redirect_to action: 'index', notice: 'Menu was successfully created.'
    else
      render 'edit'
    end
  end

  def show
    @menu = Menu.find(params[:id])
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def update
    @menu = Menu.find(params[:id])
    
    if @menu.update(menu_params)
      Rails.cache.delete @menu
      redirect_to action: 'index', notice: 'Menu was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy
    
    Rails.cache.delete @menu
    redirect_to :back, notice: 'Menu has been deleted.'
  end
  
  
  private
  
    def menu_params
      params.require(:menu).permit(:title, :key, :css_class, :notes)
    end
  
end
