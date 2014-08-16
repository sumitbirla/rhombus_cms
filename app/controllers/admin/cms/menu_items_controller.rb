class Admin::Cms::MenuItemsController < Admin::BaseController

  def new
    @menu_item = MenuItem.new title: 'New menu item', menu_id: params[:menu_id]
    render 'edit'
  end

  def create
    @menu_item = MenuItem.new(menu_item_params)
    
    if @menu_item.save
      Rails.cache.delete @menu_item.menu
      redirect_to admin_cms_menus_path
    else
      render 'edit'
    end
  end

  def edit
    @menu_item = MenuItem.find(params[:id])
  end

  def update
    @menu_item = MenuItem.find(params[:id])
    
    if @menu_item.update(menu_item_params)
      Rails.cache.delete @menu_item.menu
      redirect_to admin_cms_menus_path
    else
      render 'edit'
    end
  end

  def destroy
    @menu_item = MenuItem.find(params[:id])
    
    Rails.cache.delete @menu_item.menu
    @menu_item.destroy
    
    redirect_to admin_cms_menus_path
  end
  
  
  private
  
    def menu_item_params
      params.require(:menu_item).permit(:menu_id, :title, :link_url, :sort, :enabled)
    end
end
